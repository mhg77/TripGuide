import Foundation
import Observation

/// Отметки "забронировано/сделано" — переживают перезапуск приложения.
/// Ключ — стабильная строка (день + название брони или пункт чек-листа),
/// потому что `BookingItem.id` — UUID и меняется при каждом запуске.
@Observable
final class BookingStore {
    static let shared = BookingStore()
    private static let defaultsKey = "bookedKeys"

    private(set) var bookedKeys: Set<String>

    private init() {
        bookedKeys = Set(UserDefaults.standard.stringArray(forKey: Self.defaultsKey) ?? [])
    }

    func isBooked(_ key: String) -> Bool {
        bookedKeys.contains(key)
    }

    func toggle(_ key: String) {
        if bookedKeys.contains(key) {
            bookedKeys.remove(key)
        } else {
            bookedKeys.insert(key)
        }
        UserDefaults.standard.set(bookedKeys.sorted(), forKey: Self.defaultsKey)
    }
}

enum BookingKind {
    case ticket, hotel, restaurant, transport

    var icon: String {
        switch self {
        case .ticket: return "ticket.fill"
        case .hotel: return "bed.double.fill"
        case .restaurant: return "fork.knife"
        case .transport: return "tram.fill"
        }
    }

    var sectionTitle: String {
        switch self {
        case .ticket: return "Билеты и активности"
        case .hotel: return "Отель"
        case .restaurant: return "Рестораны с бронью"
        case .transport: return "Транспорт"
        }
    }
}

struct BookingItem: Identifiable {
    let id = UUID()
    let name: String
    let kind: BookingKind
    let note: String
    /// Проверенная официальная ссылка — только там, где она точно известна. Если nil, показываем
    /// только запасные варианты (карта / Booking.com), чтобы не подсовывать неточную ссылку.
    let officialURLString: String?
    let officialLabel: String
    let mapsQuery: String
    let bookingComQuery: String?

    init(name: String, kind: BookingKind, note: String, officialURLString: String? = nil, officialLabel: String = "Сайт", mapsQuery: String, bookingComQuery: String? = nil) {
        self.name = name
        self.kind = kind
        self.note = note
        self.officialURLString = officialURLString
        self.officialLabel = officialLabel
        self.mapsQuery = mapsQuery
        self.bookingComQuery = bookingComQuery
    }

    var officialURL: URL? {
        guard let officialURLString else { return nil }
        return URL(string: officialURLString)
    }

    var mapsURL: URL? {
        let encoded = mapsQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? mapsQuery
        return URL(string: "https://www.google.com/maps/search/?api=1&query=\(encoded)")
    }

    var bookingComURL: URL? {
        guard let bookingComQuery,
              let encoded = bookingComQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        return URL(string: "https://www.booking.com/searchresults.html?ss=\(encoded)")
    }
}
