import SwiftUI

struct RoutesView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    VStack(alignment: .leading, spacing: 4) {
                        Theme.eyebrow("Из города в город")
                            .foregroundStyle(Theme.gold)
                        Text("Автомаршруты")
                            .font(Theme.serifLargeTitle)
                            .foregroundStyle(Theme.ink)
                        Text("9 переездов · выберите, чтобы посмотреть детали и открыть навигацию")
                            .font(.subheadline)
                            .foregroundStyle(Theme.inkSecondary)
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)

                    GothicDivider()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 2)

                    VStack(spacing: 10) {
                        ForEach(RouteData.allRoutes) { route in
                            NavigationLink {
                                RouteDetailView(route: route)
                            } label: {
                                routeCard(route)
                            }
                            .buttonStyle(.plain)
                            .simultaneousGesture(TapGesture().onEnded { Haptics.tap() })
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                }
                .readableWidth()
            }
            .background(Theme.paper.ignoresSafeArea())
            .navigationTitle("Маршруты")
        }
        .preferredColorScheme(.dark)
    }

    private func routeCard(_ route: RouteLeg) -> some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(Theme.sunset.opacity(0.14))
                    .frame(width: 44, height: 44)
                    .overlay(Circle().stroke(Theme.gold.opacity(0.4), lineWidth: 1))
                Image(systemName: route.mode.icon)
                    .foregroundStyle(Theme.sunset)
                    .font(.system(size: 18, weight: .semibold))
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(route.title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Theme.ink)
                Text(route.dateLabel)
                    .font(.caption)
                    .foregroundStyle(Theme.inkSecondary)
                HStack(spacing: 6) {
                    chip(route.distance)
                    chip(route.duration)
                    if route.warning != nil {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.caption2)
                            .foregroundStyle(Theme.warning)
                    }
                }
            }

            Spacer()
            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(Theme.inkSecondary.opacity(0.6))
        }
        .padding(12)
        .gothicCard()
    }

    private func chip(_ text: String) -> some View {
        Text(text)
            .font(.caption2.weight(.medium))
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(Theme.paper)
            .clipShape(Capsule())
            .foregroundStyle(Theme.inkSecondary)
    }
}

#Preview {
    RoutesView()
}
