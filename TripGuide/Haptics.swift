import UIKit

/// Лёгкая тактильная отдача на кнопках и переходах — маленькая деталь, которая делает
/// интерфейс более живым и дружелюбным на ощупь.
enum Haptics {
    static func tap() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }

    static func success() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
}
