import Foundation
import CoreLocation
import SwiftUI
import MapKit

// MapKit не отдаёт геометрию маршрутов общественного транспорта (только время в пути),
// поэтому транзитные маршруты строим через Transitous — открытый бесплатный роутер
// на GTFS-данных (api.transitous.org, покрывает континентальную Европу; Великобритания
// вне покрытия — там остаётся fallback с ETA от MapKit).

/// Сегмент маршрута общественного транспорта: чем ехать, откуда/куда и по какой геометрии.
nonisolated struct TransitLeg: Identifiable {
    enum Mode {
        case walk, bus, tram, subway, rail, ferry, other

        var icon: String {
            switch self {
            case .walk: return "figure.walk"
            case .bus: return "bus.fill"
            case .tram, .subway: return "tram.fill"
            case .rail: return "train.side.front.car"
            case .ferry: return "ferry.fill"
            case .other: return "arrow.triangle.turn.up.right.diamond.fill"
            }
        }

        var label: String {
            switch self {
            case .walk: return "Пешком"
            case .bus: return "Автобус"
            case .tram: return "Трамвай"
            case .subway: return "Метро"
            case .rail: return "Поезд"
            case .ferry: return "Паром"
            case .other: return "Транспорт"
            }
        }

        @MainActor var color: Color {
            switch self {
            case .walk: return Theme.inkSecondary
            case .bus: return Theme.sunset
            case .tram, .subway: return Theme.info
            case .rail: return Theme.wine
            case .ferry: return Theme.fact
            case .other: return Theme.gold
            }
        }
    }

    let id = UUID()
    let mode: Mode
    let routeName: String?      // "A" (RER), "1" (метро), "EST 9014" (Евростар)
    let fromName: String
    let toName: String
    let duration: TimeInterval
    let coordinates: [CLLocationCoordinate2D]
}

nonisolated enum TransitRouting {

    struct Plan {
        let legs: [TransitLeg]
        let duration: TimeInterval
    }

    /// Запрашивает маршрут общественным транспортом. nil — сервис недоступен или
    /// направление вне покрытия (например, внутри Великобритании).
    static func plan(
        from: CLLocationCoordinate2D, fromName: String,
        to: CLLocationCoordinate2D, toName: String
    ) async -> Plan? {
        var components = URLComponents(string: "https://api.transitous.org/api/v1/plan")!
        components.queryItems = [
            URLQueryItem(name: "fromPlace", value: "\(from.latitude),\(from.longitude)"),
            URLQueryItem(name: "toPlace", value: "\(to.latitude),\(to.longitude)"),
            URLQueryItem(name: "numItineraries", value: "1"),
        ]
        guard let url = components.url else { return nil }

        var request = URLRequest(url: url)
        request.timeoutInterval = 15

        guard let (data, _) = try? await URLSession.shared.data(for: request),
              let response = try? JSONDecoder().decode(PlanResponse.self, from: data),
              let itinerary = response.itineraries.first, !itinerary.legs.isEmpty else {
            return nil
        }

        let legs = itinerary.legs.map { leg in
            TransitLeg(
                mode: TransitLeg.Mode(motis: leg.mode),
                routeName: leg.routeShortName,
                fromName: leg.from.name == "START" ? fromName : leg.from.name,
                toName: leg.to.name == "END" ? toName : leg.to.name,
                duration: leg.duration,
                coordinates: decodePolyline(leg.legGeometry.points, precision: leg.legGeometry.precision ?? 7)
            )
        }
        return Plan(legs: legs, duration: itinerary.duration)
    }

    /// Декодер полилиний в кодировке Google (Transitous использует precision 7).
    static func decodePolyline(_ encoded: String, precision: Int) -> [CLLocationCoordinate2D] {
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

    // MARK: - Формат ответа MOTIS/Transitous

    private struct PlanResponse: Decodable {
        let itineraries: [Itinerary]
    }

    private struct Itinerary: Decodable {
        let duration: TimeInterval
        let legs: [Leg]
    }

    private struct Leg: Decodable {
        let mode: String
        let routeShortName: String?
        let duration: TimeInterval
        let from: Place
        let to: Place
        let legGeometry: Geometry
    }

    private struct Place: Decodable {
        let name: String
    }

    private struct Geometry: Decodable {
        let points: String
        let precision: Int?
    }
}

private extension TransitLeg.Mode {
    nonisolated init(motis mode: String) {
        switch mode {
        case "WALK": self = .walk
        case "TRAM": self = .tram
        case "SUBWAY", "METRO": self = .subway
        case "FERRY": self = .ferry
        case let rail where rail.contains("RAIL") || rail == "SUBURBAN" || rail == "LONG_DISTANCE":
            self = .rail
        case "BUS", "COACH": self = .bus
        default: self = .other
        }
    }
}

// MARK: - Общие элементы отображения (карта дня и детали переезда)

/// Полилинии сегментов транзитного маршрута: пешие — пунктиром, транспорт — цветом режима.
struct TransitLegsOverlay: MapContent {
    let legs: [TransitLeg]

    var body: some MapContent {
        ForEach(legs) { leg in
            if leg.coordinates.count >= 2 {
                if leg.mode == .walk {
                    MapPolyline(coordinates: leg.coordinates)
                        .stroke(leg.mode.color, style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [1, 7]))
                } else {
                    MapPolyline(coordinates: leg.coordinates)
                        .stroke(leg.mode.color, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                }
            }
        }
    }
}

/// Легенда маршрута: списком, каким транспортом и до какой остановки ехать.
struct TransitLegList: View {
    let legs: [TransitLeg]

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ForEach(legs) { leg in
                HStack(spacing: 8) {
                    Image(systemName: leg.mode.icon)
                        .font(.caption)
                        .frame(width: 18)
                        .foregroundStyle(leg.mode.color)
                    Text(legTitle(leg))
                        .font(.caption)
                        .foregroundStyle(Theme.ink)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                    Spacer(minLength: 8)
                    Text(TravelFormat.duration(leg.duration))
                        .font(.caption2.weight(.medium))
                        .foregroundStyle(Theme.inkSecondary)
                }
            }
        }
    }

    private func legTitle(_ leg: TransitLeg) -> String {
        let vehicle = leg.routeName.map { "\(leg.mode.label) \($0)" } ?? leg.mode.label
        return "\(vehicle) → \(leg.toName)"
    }
}
