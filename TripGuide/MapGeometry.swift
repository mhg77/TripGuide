import MapKit

/// Общие вычисления камеры карты — раньше дублировались в MapTabView и RouteDetailView.
nonisolated enum MapGeometry {

    /// Прямоугольник, охватывающий координаты, с отступом по краям (доля размера).
    static func paddedRect(for coordinates: [CLLocationCoordinate2D], inset: Double) -> MKMapRect? {
        guard !coordinates.isEmpty else { return nil }
        var rect = MKMapRect.null
        for coordinate in coordinates {
            rect = rect.union(MKMapRect(origin: MKMapPoint(coordinate), size: MKMapSize()))
        }
        return rect.insetBy(dx: -rect.size.width * inset, dy: -rect.size.height * inset)
    }

    /// Регион, охватывающий координаты. spanFactor — запас вокруг точек,
    /// minSpan — минимальный размах, чтобы одиночная точка не давала нулевой зум.
    static func region(
        for coordinates: [CLLocationCoordinate2D],
        spanFactor: Double,
        minSpan: Double
    ) -> MKCoordinateRegion {
        guard let first = coordinates.first else {
            // Центр маршрута поездки — Париж; используется только для пустого набора.
            return MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 48.85, longitude: 2.35),
                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            )
        }
        var minLat = first.latitude, maxLat = first.latitude
        var minLon = first.longitude, maxLon = first.longitude
        for coordinate in coordinates.dropFirst() {
            minLat = min(minLat, coordinate.latitude)
            maxLat = max(maxLat, coordinate.latitude)
            minLon = min(minLon, coordinate.longitude)
            maxLon = max(maxLon, coordinate.longitude)
        }
        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2, longitude: (minLon + maxLon) / 2),
            span: MKCoordinateSpan(
                latitudeDelta: max((maxLat - minLat) * spanFactor, minSpan),
                longitudeDelta: max((maxLon - minLon) * spanFactor, minSpan)
            )
        )
    }
}
