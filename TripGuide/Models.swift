import Foundation
import CoreLocation
import SwiftUI

/// Города/точки маршрута. Раньше город был строкой, и опечатка в одном из мест
/// (данные дня, цвет, ночное фото) молча роняла день в "серый" default-вид — enum
/// делает такую рассинхронизацию ошибкой компиляции.
nonisolated enum City: String, CaseIterable {
    case london = "Лондон"
    case paris = "Париж"
    case disneyland = "Диснейленд"
    case bruges = "Брюгге"
    case beaune = "Бон"
    case annecy = "Анси"
    case chamonix = "Шамони"
    case lesArcs = "Ле-Зарк 1950"
    case preSaintDidier = "Пре-Сен-Дидье"
    case lyon = "Лион"

    /// Отображаемое имя города.
    var name: String { rawValue }

    /// Имя ночного фото в Assets.xcassets (Night*.imageset).
    var nightImageName: String {
        switch self {
        case .london: return "NightLondon"
        case .paris: return "NightParis"
        case .disneyland: return "NightDisneyland"
        case .bruges: return "NightBruges"
        case .beaune: return "NightBeaune"
        case .annecy: return "NightAnnecy"
        case .chamonix: return "NightChamonix"
        case .lesArcs: return "NightLesArcs"
        case .preSaintDidier: return "NightValleDAoste"
        case .lyon: return "NightLyon"
        }
    }
}

nonisolated enum POICategory {
    case sight, food, hotel, activity, transfer

    var icon: String {
        switch self {
        case .sight: return "camera.fill"
        case .food: return "fork.knife"
        case .hotel: return "bed.double.fill"
        case .activity: return "figure.hiking"
        case .transfer: return "car.fill"
        }
    }

    var color: Color {
        switch self {
        case .sight: return .blue
        case .food: return .orange
        case .hotel: return .purple
        case .activity: return .green
        case .transfer: return .gray
        }
    }
}

struct POI: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let category: POICategory
    let latitude: Double
    let longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    static func == (lhs: POI, rhs: POI) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

/// Короткие подписи длительности и дистанции для строк маршрутов ("~18 мин", "1,2 км").
enum TravelFormat {
    static func duration(_ seconds: TimeInterval) -> String {
        let minutes = max(1, Int((seconds / 60).rounded()))
        guard minutes >= 60 else { return "~\(minutes) мин" }
        let hours = minutes / 60
        let rest = minutes % 60
        return rest == 0 ? "~\(hours) ч" : "~\(hours) ч \(rest) мин"
    }

    static func distance(_ meters: Double) -> String {
        meters < 950 ? "\(Int(meters)) м" : String(format: "%.1f км", meters / 1000)
    }
}

struct PlanBlock: Identifiable {
    let id = UUID()
    let icon: String
    let label: String
    let text: String
}

struct TripDay: Identifiable {
    let id: Int              // 1...23
    let day: Int              // day of month (5...27), month is always September 2026
    let weekday: String       // "Сб"
    let city: City
    let subtitle: String      // short page title, e.g. "Прилёт · South Bank"
    let intro: String?        // shown only on first day of a new stop (stage overview)
    let blocks: [PlanBlock]   // Утро/Обед/День/Вечер/Ужин/Ночлег/Переезд/Билет, in page order
    let pois: [POI]
    let warning: String?      // long-day / important callout box
    let fact: String?         // "Знали ли вы?" trivia
    let todayFocus: String?   // short "Сегодня: ..." line
    let easterEggText: String?   // VoiceOver label for the hidden rain animation, on days with a pop-culture tie-in

    init(
        id: Int, day: Int, weekday: String, city: City, subtitle: String,
        intro: String?, blocks: [PlanBlock], pois: [POI],
        warning: String?, fact: String?, todayFocus: String?,
        easterEggText: String? = nil
    ) {
        self.id = id
        self.day = day
        self.weekday = weekday
        self.city = city
        self.subtitle = subtitle
        self.intro = intro
        self.blocks = blocks
        self.pois = pois
        self.warning = warning
        self.fact = fact
        self.todayFocus = todayFocus
        self.easterEggText = easterEggText
    }

    var dateLabel: String { "\(weekday) \(String(format: "%02d", day)).09" }
}
