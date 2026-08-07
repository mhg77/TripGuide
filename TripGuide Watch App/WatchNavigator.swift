import Foundation
import CoreLocation
import MapKit
import AVFoundation
import WatchKit
import Observation

/// Движок навигации по одному отрезку.
/// Пока экран открыт — держит активную сессию геопозиции (синяя точка на карте
/// и координаты для кнопки «где я»). По «Старт» считает маршрут через MKDirections
/// и ведёт по шагам MKRoute.step: подсказки манёвров озвучиваются голосом,
/// показываются всплывающим баннером и сопровождаются тактильным откликом.
@Observable
final class WatchNavigator: NSObject, CLLocationManagerDelegate {

    // Наблюдаемое состояние интерфейса.
    var statusText = "Нажмите «Старт»"
    var currentInstruction = ""
    var nextInstruction: String?
    var distanceToManeuver: CLLocationDistance = 0
    var isNavigating = false
    var arrived = false
    var errorMessage: String?
    /// Линия маршрута: сначала офлайн-геометрия, после расчёта — точная от MKDirections.
    var routeCoordinates: [CLLocationCoordinate2D]
    /// Реальное положение пользователя — для кнопки «где я» и центрирования карты.
    var userCoordinate: CLLocationCoordinate2D?
    /// Статус доступа к геопозиции — для видимой подсказки на экране.
    var authStatus: CLAuthorizationStatus = .notDetermined
    /// Растёт при каждом новом манёвре — вью показывает баннер по изменению.
    var maneuverTick = 0

    private let leg: WatchNavLeg
    private let manager = CLLocationManager()
    private var backgroundSession: CLBackgroundActivitySession?
    private let speech = AVSpeechSynthesizer()
    private var steps: [MKRoute.Step] = []
    private var stepEndCoords: [CLLocationCoordinate2D] = []
    private var stepIndex = 0
    /// «Старт» нажат, но ждём первый фикс геопозиции, чтобы строить от неё.
    private var pendingStart = false
    /// Порог (м) до конца шага, при котором считаем манёвр выполненным.
    private let maneuverThreshold: CLLocationDistance = 20

    init(leg: WatchNavLeg) {
        self.leg = leg
        self.routeCoordinates = leg.fallback
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.activityType = leg.transport == .automobile ? .automotiveNavigation : .fitness
    }

    /// Появление экрана: запрашиваем доступ и включаем поток геопозиции,
    /// чтобы точка на карте зажглась сразу, ещё до старта навигации.
    /// Если объявлен фоновый режим — держим геопозицию и когда часы «в кармане»
    /// и iPhone заблокирован (свой GPS часов + фоновая сессия).
    func activate() {
        manager.requestWhenInUseAuthorization()
        if Self.backgroundLocationEnabled {
            manager.allowsBackgroundLocationUpdates = true
            backgroundSession = CLBackgroundActivitySession()
        }
        manager.startUpdatingLocation()
    }

    func deactivate() {
        manager.stopUpdatingLocation()
        backgroundSession?.invalidate()
        backgroundSession = nil
        speech.stopSpeaking(at: .immediate)
    }

    /// Включать фоновую геопозицию можно только если в Info объявлен режим "location",
    /// иначе выставление allowsBackgroundLocationUpdates=true — фатальный краш.
    private static let backgroundLocationEnabled: Bool = {
        for key in ["WKBackgroundModes", "UIBackgroundModes"] {
            if let modes = Bundle.main.object(forInfoDictionaryKey: key) as? [String],
               modes.contains("location") {
                return true
            }
        }
        return false
    }()

    func start() {
        guard leg.supportsTurnByTurn else { return }
        errorMessage = nil
        arrived = false
        // Маршрут строим от текущего положения. Если фикса ещё нет — ждём его
        // (didUpdateLocations запустит расчёт, как только появится координата).
        if userCoordinate == nil {
            pendingStart = true
            statusText = "Определяю положение…"
            return
        }
        statusText = "Строим маршрут…"
        Task { await computeRoute() }
    }

    func stop() {
        isNavigating = false
        speech.stopSpeaking(at: .immediate)
        statusText = "Навигация остановлена"
    }

    // MARK: - Расчёт и ведение

    private func computeRoute() async {
        // Старт — от текущего положения (если есть фикс), иначе от точки отправления отрезка.
        let origin = userCoordinate ?? leg.from
        let request = MKDirections.Request()
        request.source = MKMapItem(location: CLLocation(latitude: origin.latitude, longitude: origin.longitude), address: nil)
        request.destination = MKMapItem(location: CLLocation(latitude: leg.to.latitude, longitude: leg.to.longitude), address: nil)
        request.transportType = leg.transport
        do {
            let response = try await MKDirections(request: request).calculate()
            guard let route = response.routes.first else {
                errorMessage = "Маршрут не найден"
                return
            }
            steps = route.steps
            stepEndCoords = route.steps.map { $0.polyline.coordinates.last ?? leg.to }
            routeCoordinates = route.polyline.coordinates
            stepIndex = 0
            isNavigating = true
            statusText = "В путь"
            announceCurrentStep()
        } catch {
            errorMessage = "Не удалось построить маршрут: \(error.localizedDescription)"
        }
    }

    private func advanceIfNeeded(_ location: CLLocation) {
        guard stepEndCoords.indices.contains(stepIndex) else { return }
        let target = stepEndCoords[stepIndex]
        let distance = location.distance(from: CLLocation(latitude: target.latitude, longitude: target.longitude))
        distanceToManeuver = distance
        guard distance < maneuverThreshold else { return }
        if stepIndex >= steps.count - 1 {
            arrived = true
            currentInstruction = "Вы на месте"
            nextInstruction = nil
            statusText = "Прибыли"
            maneuverTick += 1
            speak("Вы прибыли")
            WKInterfaceDevice.current().play(.success)
            stop()
        } else {
            stepIndex += 1
            announceCurrentStep()
        }
    }

    private func announceCurrentStep() {
        guard steps.indices.contains(stepIndex) else { return }
        let instruction = steps[stepIndex].instructions
        currentInstruction = instruction.isEmpty ? "Следуйте по маршруту" : instruction
        nextInstruction = steps.indices.contains(stepIndex + 1) ? steps[stepIndex + 1].instructions : nil
        maneuverTick += 1
        speak(currentInstruction)
        WKInterfaceDevice.current().play(.notification)
    }

    private func speak(_ text: String) {
        try? AVAudioSession.sharedInstance().setCategory(.playback, options: .duckOthers)
        try? AVAudioSession.sharedInstance().setActive(true)
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ru-RU")
        speech.speak(utterance)
    }

    // MARK: - CLLocationManagerDelegate
    // Колбэки CoreLocation могут приходить не на главном потоке — обновляем
    // @Observable-состояние через Task на MainActor (не падает при любом потоке).

    nonisolated func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.startUpdatingLocation()
        }
        Task { @MainActor [weak self] in
            self?.authStatus = status
        }
    }

    nonisolated func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.last?.coordinate else { return }
        Task { @MainActor [weak self] in
            guard let self else { return }
            self.userCoordinate = coordinate
            // Появился первый фикс — запускаем отложенный «Старт» от текущего положения.
            if self.pendingStart {
                self.pendingStart = false
                self.statusText = "Строим маршрут…"
                await self.computeRoute()
            }
            if self.isNavigating {
                self.advanceIfNeeded(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
            }
        }
    }

    nonisolated func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Временные ошибки (нет сигнала и т.п.) не показываем — точка появится, когда будет фикс.
    }
}

extension MKPolyline {
    /// Координаты полилинии как обычный массив.
    var coordinates: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](repeating: CLLocationCoordinate2D(), count: pointCount)
        getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))
        return coords
    }
}
