import SwiftUI

/// Экран «Авто» — 9 переездов поездки. Тап открывает навигацию по переезду.
struct WatchCarListView: View {
    var body: some View {
        NavigationStack {
            List(WatchCarData.legs) { leg in
                NavigationLink {
                    WatchNavigationView(leg: leg.navLeg)
                } label: {
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 5) {
                            Image(systemName: leg.isTrain ? "tram.fill" : "car.fill")
                                .foregroundStyle(leg.isTrain ? .blue : .orange)
                            Text(leg.dateLabel)
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                        Text(leg.title)
                            .font(.headline)
                            .lineLimit(2)
                        Text("\(leg.distance) · \(leg.duration)")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 2)
                }
            }
            .navigationTitle("Авто")
        }
    }
}
