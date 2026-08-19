import Foundation
import CoreLocation
import MapKit

/// Один авто-переезд поездки (для второго экрана «Авто»).
struct WatchCarLeg: Identifiable {
    let id: Int
    let dateLabel: String
    let title: String
    let isTrain: Bool
    let distance: String
    let duration: String
    let from: CLLocationCoordinate2D
    let to: CLLocationCoordinate2D

    /// Офлайн-геометрия переезда из общего BundledRoutes (ключ "t<id>").
    var coordinates: [CLLocationCoordinate2D] {
        guard let entry = BundledRoutes.entry(transfer: id) else { return [from, to] }
        return WatchPolyline.decode(entry.polyline, precision: entry.precision)
    }

    var navLeg: WatchNavLeg {
        WatchNavLeg(
            id: "t\(id)",
            title: title,
            from: from,
            to: to,
            transport: isTrain ? .transit : .automobile,
            fallback: coordinates
        )
    }
}

/// 7 переездов поездки; геометрия линий берётся из общего BundledRoutes.
enum WatchCarData {
    static let legs: [WatchCarLeg] = [
        WatchCarLeg(id: 1, dateLabel: "13.09", title: "Лондон → Париж", isTrain: true,
                    distance: "Евростар", duration: "~2 ч 15 мин",
                    from: .init(latitude: 51.5308, longitude: -0.1238), to: .init(latitude: 48.8809, longitude: 2.3553)),
        WatchCarLeg(id: 2, dateLabel: "17.09", title: "Диснейленд → Бон", isTrain: false,
                    distance: "~330 км", duration: "3 ч 30 мин",
                    from: .init(latitude: 48.8703, longitude: 2.7766), to: .init(latitude: 47.0235, longitude: 4.8358)),
        WatchCarLeg(id: 3, dateLabel: "18.09", title: "Бон → Анси", isTrain: false,
                    distance: "~233 км", duration: "2 ч 45 мин",
                    from: .init(latitude: 47.0235, longitude: 4.8358), to: .init(latitude: 45.8992, longitude: 6.1294)),
        WatchCarLeg(id: 4, dateLabel: "19.09", title: "Анси → Шамони", isTrain: false,
                    distance: "~99 км", duration: "1 ч 20 мин",
                    from: .init(latitude: 45.8992, longitude: 6.1294), to: .init(latitude: 45.9237, longitude: 6.8694)),
        WatchCarLeg(id: 5, dateLabel: "21.09", title: "Шамони → Ле-Зарк 1950", isTrain: false,
                    distance: "~120 км", duration: "2 ч",
                    from: .init(latitude: 45.9237, longitude: 6.8694), to: .init(latitude: 45.5720, longitude: 6.7930)),
        WatchCarLeg(id: 6, dateLabel: "24.09", title: "Ле-Зарк → Серравалле → Турин", isTrain: false,
                    distance: "~400 км", duration: "~5 ч + аутлет",
                    from: .init(latitude: 45.5720, longitude: 6.7930), to: .init(latitude: 45.0685, longitude: 7.6830)),
        WatchCarLeg(id: 7, dateLabel: "26.09", title: "Турин → Лион (аэропорт)", isTrain: false,
                    distance: "~305 км", duration: "3 ч 30 мин",
                    from: .init(latitude: 45.0685, longitude: 7.6830), to: .init(latitude: 45.7256, longitude: 5.0811)),
    ]
}
