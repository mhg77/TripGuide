import SwiftUI
import MapKit

/// Карта на весь экран: линия маршрута, реальное положение, интерактивна
/// (зум колёсиком, панорама). Кнопки: «где я» центрирует на текущей позиции,
/// «весь маршрут» вписывает линию в экран.
struct WatchFullMapView: View {
    let nav: WatchNavigator
    @State private var camera: MapCameraPosition = .userLocation(fallback: .automatic)

    var body: some View {
        Map(position: $camera) {
            if nav.routeCoordinates.count >= 2 {
                MapPolyline(coordinates: nav.routeCoordinates)
                    .stroke(.orange, lineWidth: 5)
            }
            UserAnnotation()
        }
        .ignoresSafeArea()
        .overlay(alignment: .bottomTrailing) {
            VStack(spacing: 8) {
                mapButton("location.fill", tint: .blue, action: centerOnUser)
                mapButton("arrow.up.left.and.arrow.down.right",
                          tint: .orange, action: { camera = .automatic })
            }
            .padding(8)
        }
        .navigationTitle("Карта")
    }

    private func mapButton(_ systemName: String, tint: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(tint)
                .frame(width: 34, height: 34)
                .background(.ultraThinMaterial, in: Circle())
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
}
