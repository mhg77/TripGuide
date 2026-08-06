import SwiftUI

/// Пешие отрезки одного дня. Тап открывает навигацию по выбранному отрезку.
struct WatchWalkListView: View {
    let day: TripDay

    var body: some View {
        List(WatchWalkData.legs(forDay: day.id)) { leg in
            NavigationLink {
                WatchNavigationView(leg: leg.navLeg)
            } label: {
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 4) {
                        Image(systemName: "figure.walk")
                            .foregroundStyle(.green)
                        Text(WatchFormat.distance(leg.distanceMeters))
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    Text(leg.fromName)
                        .font(.caption)
                        .lineLimit(1)
                    Label(leg.toName, systemImage: "arrow.down")
                        .font(.footnote.weight(.semibold))
                        .lineLimit(1)
                }
                .padding(.vertical, 2)
            }
        }
        .navigationTitle("День \(day.id)")
    }
}
