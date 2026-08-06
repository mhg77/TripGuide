import Foundation
import CoreLocation

/// Декодер полилиний в кодировке Google (те же данные, что и в BundledRoutes:
/// precision 5 для OSRM, 7 для Transitous). Скопирован из основного приложения,
/// чтобы watch-таргет оставался самодостаточным.
enum WatchPolyline {
    static func decode(_ encoded: String, precision: Int) -> [CLLocationCoordinate2D] {
        let factor = pow(10.0, Double(precision))
        var coordinates: [CLLocationCoordinate2D] = []
        var lat = 0, lon = 0
        var index = encoded.startIndex

        while index < encoded.endIndex {
            for isLongitude in [false, true] {
                var shift = 0
                var result = 0
                while index < encoded.endIndex {
                    let byte = Int(encoded[index].asciiValue ?? 63) - 63
                    index = encoded.index(after: index)
                    result |= (byte & 0x1F) << shift
                    shift += 5
                    if byte < 0x20 { break }
                }
                let delta = (result & 1) != 0 ? ~(result >> 1) : result >> 1
                if isLongitude { lon += delta } else { lat += delta }
            }
            coordinates.append(CLLocationCoordinate2D(
                latitude: Double(lat) / factor,
                longitude: Double(lon) / factor
            ))
        }
        return coordinates
    }
}
