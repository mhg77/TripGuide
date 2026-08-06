import SwiftUI

/// Дни поездки, в которых есть пешие маршруты. Тап открывает список отрезков дня.
struct WatchDayListView: View {
    var body: some View {
        NavigationStack {
            List(WatchWalkData.walkingDays) { day in
                NavigationLink {
                    WatchWalkListView(day: day)
                } label: {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("День \(day.id) · \(day.city.name)")
                            .font(.headline)
                        Text(day.subtitle)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                    .padding(.vertical, 2)
                }
            }
            .navigationTitle("Пешие маршруты")
        }
    }
}
