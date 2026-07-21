import SwiftUI

struct RootView: View {
    // Настоящий size class экрана — запоминаем до принудительного "compact" ниже,
    // чтобы вернуть его контенту вкладок (иначе readableWidth() перестанет работать на iPad).
    @Environment(\.horizontalSizeClass) private var realSizeClass

    var body: some View {
        TabView {
            CalendarView()
                .environment(\.horizontalSizeClass, realSizeClass)
                .tabItem {
                    Label("Календарь", systemImage: "calendar")
                }

            RoutesView()
                .environment(\.horizontalSizeClass, realSizeClass)
                .tabItem {
                    Label("Маршруты", systemImage: "car.fill")
                }

            NavigationStack {
                InfoView()
            }
            .environment(\.horizontalSizeClass, realSizeClass)
            .tabItem {
                Label("Справка", systemImage: "info.circle.fill")
            }
        }
        // На iPadOS 18+ TabView по умолчанию уезжает наверх экрана. Принудительный
        // compact-size-class возвращает привычный таб-бар внизу, удобный для большого пальца.
        .environment(\.horizontalSizeClass, .compact)
        .tint(Theme.sunset)
        .toolbarBackground(Theme.paper, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    RootView()
}
