import SwiftUI
import MapKit

/// Карта на весь экран. При наличии геопозиции и сети строит **живой маршрут от
/// текущего положения** к точке назначения (MKDirections); без них показывает
/// офлайн-линию отрезка. Кнопки: «где я» и «весь маршрут».
struct WatchFullMapView: View {
    let nav: WatchNavigator
    let leg: WatchNavLeg
    @State private var camera: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var liveRoute: [CLLocationCoordinate2D] = []
    /// Кнопки прячутся при взаимодействии с картой и возвращаются, когда движение стихло.
    @State private var controlsVisible = true
    @State private var hideTask: Task<Void, Never>?

    /// Живой маршрут от текущей позиции, если построен; иначе — офлайн-линия отрезка.
    private var displayedRoute: [CLLocationCoordinate2D] {
        liveRoute.count >= 2 ? liveRoute : nav.routeCoordinates
    }

    var body: some View {
        Map(position: $camera) {
            if displayedRoute.count >= 2 {
                MapPolyline(coordinates: displayedRoute)
                    .stroke(.orange, lineWidth: 5)
            }
            UserAnnotation()
        }
        .ignoresSafeArea()
        // Любое движение карты (жест или наши кнопки) прячет кнопки; вернём, когда стихнет.
        .onMapCameraChange(frequency: .continuous) { _ in scheduleHideControls() }
        // Тап по экрану — переключает видимость кнопок.
        .onTapGesture {
            hideTask?.cancel()
            withAnimation(.easeInOut(duration: 0.2)) { controlsVisible.toggle() }
        }
        .overlay(alignment: .bottom) {
            HStack(spacing: 12) {
                mapButton("location.fill", tint: .blue, action: centerOnUser)
                mapButton("arrow.up.left.and.arrow.down.right", tint: .orange) { camera = .automatic }
            }
            .padding(.bottom, 2)
            .opacity(controlsVisible ? 1 : 0)
            .animation(.easeInOut(duration: 0.2), value: controlsVisible)
            .allowsHitTesting(controlsVisible)
        }
        .navigationTitle("Карта")
        // Пересчитываем, как только появляется/меняется наличие геопозиции.
        .task(id: nav.userCoordinate != nil) { await buildFromCurrentLocation() }
    }

    /// Прячет кнопки на время взаимодействия и возвращает через паузу без движения.
    private func scheduleHideControls() {
        controlsVisible = false
        hideTask?.cancel()
        hideTask = Task { @MainActor in
            try? await Task.sleep(for: .seconds(1.6))
            if !Task.isCancelled { controlsVisible = true }
        }
    }

    private func mapButton(_ systemName: String, tint: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(tint)
                .frame(width: 44, height: 44)
                .background(.ultraThinMaterial, in: Circle())
                .overlay(Circle().stroke(tint.opacity(0.5), lineWidth: 1))
        }
        .buttonStyle(.plain)
    }

    private func centerOnUser() {
        if let coordinate = nav.userCoordinate {
            camera = .region(MKCoordinateRegion(
                center: coordinate,
                latitudinalMeters: 700,
                longitudinalMeters: 700
            ))
        } else {
            camera = .userLocation(fallback: .automatic)
        }
    }

    /// Строит маршрут от текущего местоположения к точке назначения через MKDirections.
    /// Нужны GPS-фикс и сеть; иначе тихо оставляем офлайн-линию.
    private func buildFromCurrentLocation() async {
        guard leg.supportsTurnByTurn, let origin = nav.userCoordinate else { return }
        let request = MKDirections.Request()
        request.source = MKMapItem(location: CLLocation(latitude: origin.latitude, longitude: origin.longitude), address: nil)
        request.destination = MKMapItem(location: CLLocation(latitude: leg.to.latitude, longitude: leg.to.longitude), address: nil)
        request.transportType = leg.transport
        if let route = try? await MKDirections(request: request).calculate().routes.first {
            liveRoute = route.polyline.coordinates
        }
    }
}
