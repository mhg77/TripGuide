import Foundation
import CoreLocation
import MapKit

/// Универсальный отрезок для экрана навигации — и для пеших маршрутов, и для авто-переездов.
struct WatchNavLeg: Identifiable {
    let id: String
    let title: String            // куда идём/едем (заголовок экрана)
    let from: CLLocationCoordinate2D
    let to: CLLocationCoordinate2D
    let transport: MKDirectionsTransportType
    /// Офлайн-геометрия для мгновенного показа линии на карте (из BundledRoutes).
    let fallback: [CLLocationCoordinate2D]

    /// У поезда (Евростар) пошагового ведения нет — только карта.
    var supportsTurnByTurn: Bool { transport != .transit }
}
