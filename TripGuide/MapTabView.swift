import SwiftUI
import MapKit
import CoreLocation

struct MapTabView: View {
    let day: TripDay

    @State private var cameraPosition: MapCameraPosition
    @State private var selectedPOI: POI?
    /// Линия маршрута до выбранной точки: вшитая геометрия по реальным дорогам,
    /// при доступной сети уточняется живыми сервисами.
    @State private var routePolyline: MKPolyline?
    @State private var routeInfo: String?
    /// Сегменты транзитного маршрута из Transitous — с геометрией и видом транспорта.
    @State private var transitLegs: [TransitLeg] = []
    /// Режим итогового маршрута — определяет иконку и travelmode для навигации.
    @State private var routeIsTransit = false
    /// Точка отправления текущего маршрута — POI, стоящая в плане дня перед выбранной.
    @State private var currentOrigin: POI?
    /// Геопозиция пользователя — синяя точка на карте и кнопка «где я».
    @State private var location = LocationProvider()
    @Environment(\.openURL) private var openURL

    init(day: TripDay) {
        self.day = day
        _cameraPosition = State(initialValue: .region(Self.regionFor(pois: day.pois)))
    }

    var body: some View {
        VStack(spacing: 0) {
            Map(position: $cameraPosition) {
                if let routePolyline {
                    MapPolyline(routePolyline)
                        .stroke(Theme.sunset, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                } else if !transitLegs.isEmpty {
                    TransitLegsOverlay(legs: transitLegs)
                } else if let currentOrigin, let selectedPOI {
                    // Пунктирное направление пока маршрут ещё грузится.
                    MapPolyline(coordinates: [currentOrigin.coordinate, selectedPOI.coordinate])
                        .stroke(Theme.sunset, style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [1, 8]))
                }

                ForEach(day.pois) { poi in
                    Annotation(poi.name, coordinate: poi.coordinate) {
                        Button {
                            Haptics.tap()
                            selectedPOI = (selectedPOI?.id == poi.id) ? nil : poi
                        } label: {
                            VStack(spacing: 2) {
                                Image(systemName: poi.category.icon)
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundStyle(.white)
                                    .padding(7)
                                    .background(poi.category.color)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle().stroke(Color.white, lineWidth: 2)
                                    )
                                if selectedPOI?.id == poi.id {
                                    Text(poi.name)
                                        .font(.caption2.weight(.semibold))
                                        .padding(.horizontal, 6)
                                        .padding(.vertical, 3)
                                        .background(.thinMaterial)
                                        .clipShape(RoundedRectangle(cornerRadius: 6))
                                        .fixedSize()
                                }
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }

                UserAnnotation()
            }
            .mapStyle(.standard)
            .ignoresSafeArea(edges: .bottom)
            .overlay(alignment: .topTrailing) {
                locateButton
                    .padding(10)
            }

            if let routeInfo {
                routeBar(routeInfo)
            }

            if !transitLegs.isEmpty {
                TransitLegList(legs: transitLegs)
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                    .background(.bar)
            }

            if !day.pois.isEmpty {
                legend
            }
        }
        .task(id: selectedPOI) { await updateRoute() }
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
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(location.coordinate == nil ? Theme.inkSecondary : Theme.info)
                .frame(width: 38, height: 38)
                .background(.thinMaterial, in: Circle())
                .overlay(Circle().stroke(Theme.gold.opacity(0.35), lineWidth: 1))
        }
        .buttonStyle(.plain)
        .disabled(location.coordinate == nil)
    }

    /// Строит маршрут от предыдущей точки плана к выбранной: мгновенно показывает
    /// вшитую линию по реальным дорогам, затем для дальних точек пробует Transitous
    /// (сегменты и легенда общественного транспорта), когда есть сеть.
    private func updateRoute() async {
        routePolyline = nil
        routeInfo = nil
        routeIsTransit = false
        transitLegs = []
        currentOrigin = nil
        // Маршрут — от предыдущей точки в плане к выбранной (цепочка: отель→А, А→В, В→С).
        guard let selectedPOI,
              let poiIndex = day.pois.firstIndex(where: { $0.id == selectedPOI.id }),
              poiIndex > 0 else { return }
        let origin = day.pois[poiIndex - 1]
        currentOrigin = origin

        // Далёкой считаем точку не-пешего вшитого маршрута; без вшитых данных — свыше 5 км.
        let bundled = BundledRoutes.entry(day: day.id, poiIndex: poiIndex)
        let isFar = bundled.map { !$0.isWalk } ?? (CLLocation(latitude: origin.latitude, longitude: origin.longitude)
            .distance(from: CLLocation(latitude: selectedPOI.latitude, longitude: selectedPOI.longitude)) > 5000)

        // 1. Вшитая геометрия по реальным дорогам — мгновенно и без сети.
        if let bundled {
            let coords = TransitRouting.decodePolyline(bundled.polyline, precision: bundled.precision)
            if coords.count >= 2 {
                routePolyline = MKPolyline(coordinates: coords, count: coords.count)
                routeIsTransit = !bundled.isWalk
                routeInfo = bundled.isWalk
                    ? "Пешком \(TravelFormat.duration(bundled.durationSeconds)) · \(TravelFormat.distance(bundled.distanceMeters))"
                    : "\(TravelFormat.distance(bundled.distanceMeters)) от «\(origin.name)» — транспортом или на такси"
                fitCamera(to: coords)
            }
        } else {
            routeInfo = "Строю маршрут…"
        }

        // 2. Для дальних точек пробуем Transitous — он добавит сегменты и легенду
        //    (каким транспортом ехать). Вшитая линия остаётся, если сети нет.
        if isFar, let plan = await TransitRouting.plan(
            from: origin.coordinate, fromName: origin.name,
            to: selectedPOI.coordinate, toName: selectedPOI.name
        ) {
            routePolyline = nil
            routeIsTransit = true
            transitLegs = plan.legs
            routeInfo = "Транспортом \(TravelFormat.duration(plan.duration)) от «\(origin.name)»"
            fitCamera(to: plan.legs.flatMap(\.coordinates))
            return
        }

        // 3. Вшитой геометрии нет (канатная дорога, кораблик) и сеть не ответила —
        //    последняя попытка: живой запрос MKDirections.
        guard routePolyline == nil, transitLegs.isEmpty else { return }
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: origin.coordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: selectedPOI.coordinate))
        request.transportType = isFar ? .automobile : .walking
        if let route = try? await MKDirections(request: request).calculate().routes.first {
            routePolyline = route.polyline
            routeIsTransit = isFar
            routeInfo = (isFar ? "" : "Пешком ") + "\(TravelFormat.duration(route.expectedTravelTime)) · \(TravelFormat.distance(route.distance))"
            let rect = route.polyline.boundingMapRect
            withAnimation(.easeInOut(duration: 0.5)) {
                cameraPosition = .rect(rect.insetBy(dx: -rect.size.width * 0.3, dy: -rect.size.height * 0.3))
            }
        } else {
            routeInfo = "Прямой дороги нет (канатка/кораблик) — линия показывает направление"
            withAnimation(.easeInOut(duration: 0.5)) {
                cameraPosition = .region(Self.regionFor(pois: [origin, selectedPOI]))
            }
        }
    }

    /// Подгоняет камеру под набор координат (весь маршрут целиком).
    private func fitCamera(to coordinates: [CLLocationCoordinate2D]) {
        guard let rect = MapGeometry.paddedRect(for: coordinates, inset: 0.2) else { return }
        withAnimation(.easeInOut(duration: 0.5)) {
            cameraPosition = .rect(rect)
        }
    }

    /// Ссылка на пошаговую навигацию Google Maps в подходящем режиме.
    private func googleDirectionsURL(from: POI, to: POI) -> URL? {
        let mode = routeIsTransit ? "transit" : "walking"
        let string = "https://www.google.com/maps/dir/?api=1&origin=\(from.latitude),\(from.longitude)&destination=\(to.latitude),\(to.longitude)&travelmode=\(mode)"
        return URL(string: string)
    }

    private func routeBar(_ text: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: routeIsTransit ? "bus.fill" : "figure.walk")
                .foregroundStyle(Theme.sunset)
            Text(text)
                .font(.caption.weight(.medium))
                .foregroundStyle(Theme.ink)
                .lineLimit(1)
                .minimumScaleFactor(0.75)

            Spacer(minLength: 8)

            if let currentOrigin, let selectedPOI,
               let url = googleDirectionsURL(from: currentOrigin, to: selectedPOI) {
                Button {
                    Haptics.tap()
                    openURL(url)
                } label: {
                    Label("Навигация", systemImage: "arrow.triangle.turn.up.right.circle.fill")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Theme.sunset)
                }
                .buttonStyle(.pressable)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(.bar)
    }

    private var legend: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(day.pois) { poi in
                    Button {
                        Haptics.tap()
                        selectedPOI = (selectedPOI?.id == poi.id) ? nil : poi
                        if selectedPOI != nil {
                            withAnimation {
                                cameraPosition = .region(
                                    MKCoordinateRegion(center: poi.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04))
                                )
                            }
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: poi.category.icon)
                                .foregroundStyle(poi.category.color)
                            Text(poi.name)
                                .font(.caption)
                                .lineLimit(1)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(Capsule())
                        .overlay(
                            Capsule().stroke(
                                selectedPOI?.id == poi.id ? Theme.sunset.opacity(0.8) : Theme.gold.opacity(0.35),
                                lineWidth: 1
                            )
                        )
                    }
                    .buttonStyle(.pressable)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
        .background(.bar)
    }

    static func regionFor(pois: [POI]) -> MKCoordinateRegion {
        MapGeometry.region(for: pois.map(\.coordinate), spanFactor: 1.8, minSpan: 0.03)
    }
}

#Preview {
    MapTabView(day: TripData.allDays[13])
}
