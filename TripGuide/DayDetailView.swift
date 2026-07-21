import SwiftUI

struct DayDetailView: View {
    /// Текущий отображаемый день — меняется на месте при свайпе, без push/pop навигации,
    /// поэтому переход между днями лёгкий и не растит стек навигации.
    @State private var currentDay: TripDay
    @State private var transitionEdge: Edge = .trailing
    @Environment(\.horizontalSizeClass) private var realSizeClass

    init(day: TripDay) {
        _currentDay = State(initialValue: day)
    }

    private var currentIndex: Int {
        TripData.allDays.firstIndex(where: { $0.id == currentDay.id }) ?? 0
    }
    private var previousDay: TripDay? {
        let i = currentIndex
        return i > 0 ? TripData.allDays[i - 1] : nil
    }
    private var nextDay: TripDay? {
        let i = currentIndex
        return i < TripData.allDays.count - 1 ? TripData.allDays[i + 1] : nil
    }

    private func goToNext() {
        guard let next = nextDay else { return }
        Haptics.tap()
        transitionEdge = .trailing
        withAnimation(.easeInOut(duration: 0.24)) { currentDay = next }
    }

    private func goToPrevious() {
        guard let previous = previousDay else { return }
        Haptics.tap()
        transitionEdge = .leading
        withAnimation(.easeInOut(duration: 0.24)) { currentDay = previous }
    }

    var body: some View {
        TabView {
            DayPlanView(day: currentDay, onSwipeNext: goToNext, onSwipePrevious: goToPrevious)
                .environment(\.horizontalSizeClass, realSizeClass)
                .tabItem {
                    Label("План", systemImage: "list.bullet.clipboard")
                }

            MapTabView(day: currentDay)
                .environment(\.horizontalSizeClass, realSizeClass)
                .tabItem {
                    Label("Карта", systemImage: "map")
                }

            BookingsTabView(day: currentDay, onSwipeNext: goToNext, onSwipePrevious: goToPrevious)
                .environment(\.horizontalSizeClass, realSizeClass)
                .tabItem {
                    Label("Брони и билеты", systemImage: "ticket.fill")
                }
        }
        // Полная пересборка при смене дня — иначе внутренние @State карты (позиция камеры,
        // выбранная точка) остались бы от предыдущего дня.
        .id(currentDay.id)
        .transition(.move(edge: transitionEdge).combined(with: .opacity))
        // Тот же трюк, что и в RootView — без него на iPadOS 18+ этот таб-бар тоже уедет
        // наверх, а вместе с ним сломается свайп между днями (жест конфликтует с новым
        // адаптивным таб-баром).
        .environment(\.horizontalSizeClass, .compact)
        .tint(Theme.cityColor(currentDay.city))
        .navigationTitle("День \(currentDay.id) · \(currentDay.dateLabel)")
        .navigationBarTitleDisplayMode(.inline)
        // Прячем корневой таб-бар (Календарь/Маршруты), пока открыт день — иначе он
        // накладывается на локальный таб-бар "План/Карта" этого экрана.
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    NavigationStack {
        DayDetailView(day: TripData.allDays[0])
    }
}
