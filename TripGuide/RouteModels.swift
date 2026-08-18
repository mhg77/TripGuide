import Foundation
import CoreLocation

enum TransportMode {
    case car, train

    var icon: String {
        switch self {
        case .car: return "car.fill"
        case .train: return "tram.fill"
        }
    }

    var label: String {
        switch self {
        case .car: return "На машине"
        case .train: return "Евростар"
        }
    }
}

/// Промежуточная остановка в маршруте переезда: заезд по дороге или ключевая точка пути.
struct RouteWaypoint: Identifiable {
    let id = UUID()
    let name: String
    let lat: Double
    let lon: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
}

struct RouteLeg: Identifiable {
    let id: Int
    let dateLabel: String        // "17.09"
    let title: String            // "Диснейленд → Бон"
    let mode: TransportMode
    let distance: String         // "~307 км"
    let duration: String         // "3 ч 30 мин"
    let roadNote: String
    let warning: String?
    let originName: String
    let originLat: Double
    let originLon: Double
    let destinationName: String
    let destLat: Double
    let destLon: Double
    /// Промежуточные остановки: для автомаршрута — заезды; для поезда — ключевые точки пути.
    let waypoints: [RouteWaypoint]

    init(
        id: Int, dateLabel: String, title: String, mode: TransportMode,
        distance: String, duration: String, roadNote: String, warning: String?,
        originName: String, originLat: Double, originLon: Double,
        destinationName: String, destLat: Double, destLon: Double,
        waypoints: [RouteWaypoint] = []
    ) {
        self.id = id
        self.dateLabel = dateLabel
        self.title = title
        self.mode = mode
        self.distance = distance
        self.duration = duration
        self.roadNote = roadNote
        self.warning = warning
        self.originName = originName
        self.originLat = originLat
        self.originLon = originLon
        self.destinationName = destinationName
        self.destLat = destLat
        self.destLon = destLon
        self.waypoints = waypoints
    }

    var originCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: originLat, longitude: originLon)
    }
    var destinationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: destLat, longitude: destLon)
    }

    /// Все координаты маршрута: начало + путевые точки + конец (для камеры и fallback-линии).
    var allCoordinates: [CLLocationCoordinate2D] {
        [originCoordinate] + waypoints.map(\.coordinate) + [destinationCoordinate]
    }

    /// Ссылка Google Maps на маршрут от текущего местоположения пользователя к точке
    /// назначения. Origin не задаём — Google строит от «Вашего местоположения».
    var googleMapsURL: URL? {
        let travelmode = (mode == .car) ? "driving" : "transit"
        return URL(string: "https://www.google.com/maps/dir/?api=1&destination=\(destLat),\(destLon)&travelmode=\(travelmode)")
    }
}
