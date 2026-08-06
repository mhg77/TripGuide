import SwiftUI
import MapKit

/// Экран навигации по отрезку (пешему или авто).
/// Сверху — превью карты с реальным положением и линией маршрута; тап открывает
/// карту на весь экран. Манёвры показываются всплывающим баннером-уведомлением,
/// озвучиваются голосом и сопровождаются вибрацией.
struct WatchNavigationView: View {
    let leg: WatchNavLeg
    @State private var nav: WatchNavigator
    @State private var camera: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var bannerText: String?

    init(leg: WatchNavLeg) {
        self.leg = leg
        _nav = State(initialValue: WatchNavigator(leg: leg))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                // Превью карты — некликабельная (жесты выключены), тап открывает полный экран.
                NavigationLink {
                    WatchFullMapView(nav: nav)
                } label: {
                    mapPreview
                }
                .buttonStyle(.plain)

                locationStatus

                if let error = nav.errorMessage {
                    Text(error)
                        .font(.footnote)
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)
                }

                if leg.supportsTurnByTurn {
                    controls
                } else {
                    trainNotice
                }
            }
            .padding(.horizontal, 4)
        }
        .navigationTitle(leg.title)
        .overlay(alignment: .top) { banner }
        .onAppear { nav.activate() }
        .onDisappear { nav.deactivate() }
        .onChange(of: nav.maneuverTick) { _, _ in
            showBanner(nav.currentInstruction)
        }
    }

    /// Видимый статус геопозиции — сразу понятно, где затык (нет доступа / ждём фикс).
    @ViewBuilder private var locationStatus: some View {
        switch nav.authStatus {
        case .denied, .restricted:
            label("Геопозиция запрещена — Настройки часов ▸ Конфиденциальность ▸ Службы геолокации ▸ TripGuide",
                  icon: "location.slash.fill", color: .red)
        case .notDetermined:
            label("Запрашиваю доступ к геопозиции…", icon: "location.circle", color: .secondary)
        default:
            if nav.userCoordinate == nil {
                label("Определяю положение…", icon: "location.circle", color: .secondary)
            } else {
                label("Геопозиция активна", icon: "location.fill", color: .green)
            }
        }
    }

    private func label(_ text: String, icon: String, color: Color) -> some View {
        HStack(spacing: 5) {
            Image(systemName: icon)
            Text(text)
                .fixedSize(horizontal: false, vertical: true)
        }
        .font(.caption2)
        .foregroundStyle(color)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var mapPreview: some View {
        Map(position: $camera) {
            if nav.routeCoordinates.count >= 2 {
                MapPolyline(coordinates: nav.routeCoordinates)
                    .stroke(.orange, lineWidth: 4)
            }
            UserAnnotation()
        }
        .frame(height: 120)
        .allowsHitTesting(false)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(alignment: .bottomTrailing) {
            Image(systemName: "arrow.up.left.and.arrow.down.right")
                .font(.caption2)
                .padding(4)
                .background(.black.opacity(0.5), in: Circle())
                .padding(4)
        }
    }

    private var controls: some View {
        VStack(spacing: 8) {
            if nav.isNavigating || nav.arrived {
                instructionCard
            } else {
                Text(nav.statusText)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            Button {
                if nav.isNavigating {
                    nav.stop()
                } else {
                    camera = .userLocation(fallback: .automatic)
                    nav.start()
                }
            } label: {
                Label(nav.isNavigating ? "Стоп" : "Старт",
                      systemImage: nav.isNavigating ? "stop.fill" : "location.fill")
                    .frame(maxWidth: .infinity)
            }
            .tint(nav.isNavigating ? .red : (leg.transport == .automobile ? .orange : .green))
        }
    }

    private var instructionCard: some View {
        VStack(alignment: .leading, spacing: 4) {
            if nav.distanceToManeuver > 0 && !nav.arrived {
                Text(WatchFormat.distance(nav.distanceToManeuver))
                    .font(.title3.bold())
                    .foregroundStyle(.orange)
            }
            Text(nav.currentInstruction)
                .font(.headline)
                .fixedSize(horizontal: false, vertical: true)
            if let next = nav.nextInstruction, !next.isEmpty {
                Label(next, systemImage: "arrow.turn.up.right")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
        .background(.gray.opacity(0.2), in: RoundedRectangle(cornerRadius: 10))
    }

    private var trainNotice: some View {
        VStack(spacing: 6) {
            Image(systemName: "tram.fill")
                .font(.title2)
                .foregroundStyle(.blue)
            Text("Евростар — поезд")
                .font(.headline)
            Text("Пошаговая навигация только для авто и пеших маршрутов. Здесь — обзор маршрута на карте.")
                .font(.caption2)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(8)
    }

    /// Всплывающее уведомление о манёвре сверху экрана.
    @ViewBuilder private var banner: some View {
        if let text = bannerText {
            HStack(spacing: 6) {
                Image(systemName: "arrow.triangle.turn.up.right.diamond.fill")
                    .foregroundStyle(.orange)
                Text(text)
                    .font(.caption2.weight(.semibold))
                    .lineLimit(2)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(.ultraThinMaterial, in: Capsule())
            .padding(.top, 2)
            .transition(.move(edge: .top).combined(with: .opacity))
        }
    }

    private func showBanner(_ text: String) {
        withAnimation(.spring(duration: 0.3)) { bannerText = text }
        Task {
            try? await Task.sleep(for: .seconds(4))
            withAnimation(.easeOut) { bannerText = nil }
        }
    }
}
