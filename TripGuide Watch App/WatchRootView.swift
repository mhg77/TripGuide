import SwiftUI

/// Корень watch-приложения: два экрана-вкладки — «Пешком» и «Авто» (свайп между ними).
struct WatchRootView: View {
    var body: some View {
        TabView {
            WatchDayListView()   // Пешие маршруты
            WatchCarListView()   // Автомобильные переезды
        }
    }
}
