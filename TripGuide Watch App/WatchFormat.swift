import Foundation

/// Короткие подписи дистанции для списка и подсказок навигации ("120 м", "1,4 км").
enum WatchFormat {
    static func distance(_ meters: Double) -> String {
        if meters < 950 {
            return "\(Int((meters / 10).rounded()) * 10) м"
        }
        return String(format: "%.1f км", meters / 1000)
    }
}
