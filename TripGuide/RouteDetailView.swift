import SwiftUI
import MapKit

struct RouteDetailView: View {
    let route: RouteLeg

    @State private var cameraPosition: MapCameraPosition
    /// Линия маршрута по реальным дорогам: мгновенно из вшитой геометрии,
    /// при доступной сети заменяется более детальной от MKDirections.
    @State private var roadPolyline: MKPolyline?
    /// Сегменты маршрута Евростара из Transitous — с геометрией и видом транспорта.
    @State private var transitLegs: [TransitLeg] = []
    /// Геопозиция пользователя — синяя точка на карте и кнопка «где я».
    @State private var location = LocationProvider()
    @Environment(\.openURL) private var openURL
    @Environment(\.horizontalSizeClass) private var sizeClass

    init(route: RouteLeg) {
        self.route = route
        _cameraPosition = State(initialValue: .region(
            MapGeometry.region(for: route.allCoordinates, spanFactor: 1.6, minSpan: 0.4)
        ))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                mapCard

                HStack(spacing: 10) {
                    infoPill(icon: "ruler", value: route.distance)
                    infoPill(icon: "clock", value: route.duration)
                    infoPill(icon: route.mode.icon, value: route.mode.label)
                }
                .padding(.horizontal)

                HStack(spacing: 8) {
                    Image(systemName: "location.circle.fill")
                        .foregroundStyle(Theme.sunset)
                    Text(route.originName)
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(Theme.ink)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                    Image(systemName: "arrow.right")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Theme.gold)
                    Text(route.destinationName)
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(Theme.ink)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                    Spacer(minLength: 0)
                }
                .padding(14)
                .gothicCard()
                .padding(.horizontal)

                infoCard(text: route.roadNote, color: Theme.info, icon: "signpost.right.fill", title: "Дорога")

                if let warning = route.warning {
                    infoCard(text: warning, color: Theme.warning, icon: "exclamationmark.triangle.fill", title: "Важно")
                }

                routeStatus

                mapsButton
                    .padding(.horizontal)
                    .padding(.bottom, 24)
            }
            .padding(.top, 8)
            .readableWidth()
        }
        .background(Theme.paper.ignoresSafeArea())
        .navigationTitle(route.title)
        .navigationBarTitleDisplayMode(.inline)
        .task { await loadRoadRoute() }
        .onAppear { location.start() }
        .onDisappear { location.stop() }
    }

    /// Кнопка «где я»: центрирует карту на текущей геопозиции.
    private var locateButton: some View {
        Button {
            guard let coordinate = location.coordinate else { return }
            Haptics.tap()
            withAnimation(.easeInOut(duration: 0.4)) {
                cameraPosition = .region(MKCoordinateRegion(
                    center: coordinate,
                    latitudinalMeters: 1200, longitudinalMeters: 1200
                ))
            }
        } label: {
            Image(systemName: "location.fill")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(location.coordinate == nil ? Theme.inkSecondary : Theme.info)
                .frame(width: 46, height: 46)
                .background(.thinMaterial, in: Circle())
                .overlay(Circle().stroke(Theme.gold.opacity(0.4), lineWidth: 1))
                .shadow(color: .black.opacity(0.25), radius: 4, y: 2)
        }
        .buttonStyle(.plain)
        .disabled(location.coordinate == nil)
    }

    /// Пояснение под картой для Евростара: легенда сегментов из Transitous,
    /// либо подпись о вшитой ж/д линии, пока сеть недоступна.
    @ViewBuilder
    private var routeStatus: some View {
        if route.mode == .train {
            if !transitLegs.isEmpty {
                TransitLegList(legs: transitLegs)
                    .padding(12)
                    .gothicCard()
                    .padding(.horizontal)
            } else {
                Text("Линия на карте — маршрут Евростара по железной дороге.")
                    .font(.caption)
                    .foregroundStyle(Theme.inkSecondary)
                    .padding(.horizontal)
            }
        }
    }

    /// Показывает маршрут по реальным дорогам. Основной источник — вшитая геометрия
    /// (BundledRoutes, работает мгновенно и без сети); для Евростара дополнительно
    /// запрашиваем Transitous, чтобы показать легенду сегментов.
    private func loadRoadRoute() async {
        // 1. Вшитая геометрия по реальным дорогам (для Евростара — по рельсам).
        if roadPolyline == nil, let bundled = BundledRoutes.entry(transfer: route.id) {
            let coords = TransitRouting.decodePolyline(bundled.polyline, precision: bundled.precision)
            if coords.count >= 2 {
                roadPolyline = MKPolyline(coordinates: coords, count: coords.count)
                fitCamera(to: coords)
            }
        }

        if route.mode == .train {
            // Transitous добавляет легенду: каким поездом и с какими пересадками.
            if transitLegs.isEmpty, let plan = await TransitRouting.plan(
                from: route.originCoordinate, fromName: route.originName,
                to: route.destinationCoordinate, toName: route.destinationName
            ) {
                transitLegs = plan.legs
                roadPolyline = nil
                fitCamera(to: plan.legs.flatMap(\.coordinates))
            }
            return
        }

        // 2. Живой маршрут MKDirections через путевые точки — самая детальная
        //    геометрия. Он заменяет вшитую линию, когда сеть есть;
        //    без сети остаётся вшитая, ошибку не показываем.
        let stops = route.allCoordinates
        var mergedCoords: [CLLocationCoordinate2D] = []
        for i in 0..<(stops.count - 1) {
            let req = MKDirections.Request()
            req.source = MKMapItem(placemark: MKPlacemark(coordinate: stops[i]))
            req.destination = MKMapItem(placemark: MKPlacemark(coordinate: stops[i + 1]))
            req.transportType = .automobile
            guard let segment = try? await MKDirections(request: req).calculate().routes.first else { return }
            var segCoords = [CLLocationCoordinate2D](
                repeating: CLLocationCoordinate2D(),
                count: segment.polyline.pointCount
            )
            segment.polyline.getCoordinates(&segCoords, range: NSRange(location: 0, length: segment.polyline.pointCount))
            mergedCoords.append(contentsOf: segCoords)
        }
        guard mergedCoords.count >= 2 else { return }
        roadPolyline = MKPolyline(coordinates: mergedCoords, count: mergedCoords.count)
        fitCamera(to: mergedCoords)
    }

    /// Подгоняет камеру под набор координат (весь маршрут целиком).
    private func fitCamera(to coordinates: [CLLocationCoordinate2D]) {
        guard let rect = MapGeometry.paddedRect(for: coordinates, inset: 0.15) else { return }
        withAnimation(.easeInOut(duration: 0.6)) {
            cameraPosition = .rect(rect)
        }
    }

    private var mapCard: some View {
        Map(position: $cameraPosition) {
            Marker(route.originName, systemImage: "flag.circle.fill", coordinate: route.originCoordinate)
                .tint(Theme.sunset)
            Marker(route.destinationName, systemImage: "mappin.circle.fill", coordinate: route.destinationCoordinate)
                .tint(Theme.info)
            // Промежуточные остановки: золотые маркеры
            ForEach(route.waypoints) { wp in
                Marker(wp.name, systemImage: "mappin.circle.fill", coordinate: wp.coordinate)
                    .tint(Theme.gold)
            }
            if let roadPolyline {
                MapPolyline(roadPolyline)
                    .stroke(Theme.sunset, style: StrokeStyle(lineWidth: 4, lineCap: .round))
            } else if !transitLegs.isEmpty {
                TransitLegsOverlay(legs: transitLegs)
            } else {
                // Пока маршрут грузится (или для поезда): пунктирная линия через ключевые точки.
                MapPolyline(coordinates: route.allCoordinates)
                    .stroke(Theme.sunset, style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: [1, 10]))
            }

            UserAnnotation()
        }
        // На iPad (regular) карте достаётся больше высоты — 260 pt там выглядят маркой.
        .frame(height: sizeClass == .regular ? 420 : 260)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Theme.gold.opacity(0.4), lineWidth: 1.5)
        )
        .overlay(alignment: .bottomTrailing) {
            locateButton
                .padding(14)
        }
        .padding(.horizontal)
    }

    private var mapsButton: some View {
        Button {
            Haptics.tap()
            if let url = route.googleMapsURL {
                openURL(url)
            }
        } label: {
            Label("Открыть в Google Maps", systemImage: "arrow.triangle.turn.up.right.diamond.fill")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Theme.sunset)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .stroke(Theme.goldLight.opacity(0.6), lineWidth: 1)
                )
        }
        .buttonStyle(.pressable)
    }

    private func infoPill(icon: String, value: String) -> some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .foregroundStyle(Theme.sunset)
            Text(value)
                .font(.caption.weight(.semibold))
                .foregroundStyle(Theme.ink)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .gothicCard(cornerRadius: 14)
    }

    private func infoCard(text: String, color: Color, icon: String, title: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 6) {
                Image(systemName: icon).foregroundStyle(color)
                Text(title).font(.caption.weight(.bold)).foregroundStyle(color)
            }
            Text(text)
                .font(.subheadline)
                .foregroundStyle(Theme.ink.opacity(0.9))
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(color.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(color.opacity(0.25), lineWidth: 1)
        )
        .padding(.horizontal)
    }

}

#Preview {
    NavigationStack {
        RouteDetailView(route: RouteData.allRoutes[2])
    }
}
