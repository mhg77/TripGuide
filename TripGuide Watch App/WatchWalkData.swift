import Foundation
import CoreLocation
import MapKit

/// Один пеший отрезок дня: от точки к точке, с офлайн-геометрией из BundledRoutes.
struct WatchWalkLeg: Identifiable {
    let id: String            // "d2-3"
    let dayID: Int
    let fromName: String
    let toName: String
    let from: CLLocationCoordinate2D
    let to: CLLocationCoordinate2D
    let distanceMeters: Double
    let coordinates: [CLLocationCoordinate2D]   // офлайн-линия для показа сразу, без сети

    var navLeg: WatchNavLeg {
        WatchNavLeg(
            id: id,
            title: toName,
            from: from,
            to: to,
            transport: .walking,
            fallback: coordinates
        )
    }
}

/// Собирает пешие отрезки из данных поездки: берём соседние точки каждого дня,
/// для которых во вшитых маршрутах стоит признак isWalk. Данные (TripData,
/// BundledRoutes, Models) общие с основным приложением — расхождений нет.
enum WatchWalkData {
    static let legs: [WatchWalkLeg] = build()

    static func legs(forDay id: Int) -> [WatchWalkLeg] {
        legs.filter { $0.dayID == id }
    }

    /// Дни, в которых есть хотя бы один пеший отрезок.
    static var walkingDays: [TripDay] {
        let ids = Set(legs.map(\.dayID))
        return TripData.allDays.filter { ids.contains($0.id) }
    }

    private static func build() -> [WatchWalkLeg] {
        var result: [WatchWalkLeg] = []
        for day in TripData.allDays {
            guard day.pois.count >= 2 else { continue }
            for index in 1..<day.pois.count {
                guard let entry = BundledRoutes.entry(day: day.id, poiIndex: index), entry.isWalk else { continue }
                let a = day.pois[index - 1]
                let b = day.pois[index]
                result.append(
                    WatchWalkLeg(
                        id: "d\(day.id)-\(index)",
                        dayID: day.id,
                        fromName: a.name,
                        toName: b.name,
                        from: a.coordinate,
                        to: b.coordinate,
                        distanceMeters: entry.distanceMeters,
                        coordinates: WatchPolyline.decode(entry.polyline, precision: entry.precision)
                    )
                )
            }
        }
        return result
    }
}
