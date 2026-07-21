import SwiftUI

struct BookingsTabView: View {
    let day: TripDay
    var onSwipeNext: (() -> Void)? = nil
    var onSwipePrevious: (() -> Void)? = nil

    @Environment(\.openURL) private var openURL
    private let store = BookingStore.shared

    private var items: [BookingItem] { BookingData.items(for: day.id) }

    /// Стабильный ключ отметки "забронировано" — по дню и названию, не по UUID.
    private func bookedKey(_ item: BookingItem) -> String {
        "booking-\(day.id)-\(item.name)"
    }
    private var grouped: [(BookingKind, [BookingItem])] {
        let order: [BookingKind] = [.transport, .ticket, .hotel, .restaurant]
        return order.compactMap { kind in
            let matching = items.filter { $0.kind == kind }
            return matching.isEmpty ? nil : (kind, matching)
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if items.isEmpty {
                    emptyState
                } else {
                    ForEach(Array(grouped.enumerated()), id: \.offset) { _, group in
                        VStack(alignment: .leading, spacing: 10) {
                            Theme.eyebrow(group.0.sectionTitle)
                                .foregroundStyle(Theme.gold)
                                .padding(.horizontal)

                            VStack(spacing: 10) {
                                ForEach(group.1) { item in
                                    bookingCard(item)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .padding(.vertical, 16)
            .readableWidth()
        }
        .background(Theme.paper.ignoresSafeArea())
        .daySwipeNavigation(onNext: { onSwipeNext?() }, onPrevious: { onSwipePrevious?() })
    }

    private var emptyState: some View {
        VStack(spacing: 10) {
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 36))
                .foregroundStyle(Theme.cityColor(day.city))
                .symbolEffect(.bounce, value: day.id)
            Text("На этот день ничего бронировать не нужно")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(Theme.ink)
            Text("Билеты, отели и рестораны с обязательной бронью появляются здесь только там, где они реально нужны по плану.")
                .font(.caption)
                .foregroundStyle(Theme.inkSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 60)
    }

    private func bookingCard(_ item: BookingItem) -> some View {
        let key = bookedKey(item)
        let isBooked = store.isBooked(key)

        return VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, spacing: 10) {
                Group {
                    Image(systemName: item.kind.icon)
                        .frame(width: 30, height: 30)
                        .background(Theme.cityColor(day.city).opacity(0.14))
                        .foregroundStyle(Theme.cityColor(day.city))
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Theme.gold.opacity(0.35), lineWidth: 1))

                    VStack(alignment: .leading, spacing: 2) {
                        Text(item.name)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(Theme.ink)
                        Text(item.note)
                            .font(.caption)
                            .foregroundStyle(Theme.inkSecondary)
                    }
                }
                .opacity(isBooked ? 0.55 : 1)
                Spacer(minLength: 0)

                Button {
                    // Успешная бронь — "весомый" хаптик, снятие отметки — обычный тап.
                    if isBooked { Haptics.tap() } else { Haptics.success() }
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        store.toggle(key)
                    }
                } label: {
                    Image(systemName: isBooked ? "checkmark.circle.fill" : "circle")
                        .font(.system(size: 24))
                        .foregroundStyle(isBooked ? Theme.success : Theme.inkSecondary.opacity(0.5))
                }
                .buttonStyle(.pressable)
                .accessibilityLabel(isBooked ? "Забронировано" : "Отметить забронированным")
            }

            if !isBooked {
                HStack(spacing: 8) {
                    if let url = item.officialURL {
                        actionButton(title: item.officialLabel, icon: "arrow.up.right.square.fill", filled: true) {
                            openURL(url)
                        }
                    }
                    if let url = item.bookingComURL {
                        actionButton(title: "Booking.com", icon: "building.2.fill", filled: item.officialURL == nil) {
                            openURL(url)
                        }
                    }
                    if let url = item.mapsURL {
                        actionButton(title: "Карта", icon: "mappin.and.ellipse", filled: item.officialURL == nil && item.bookingComURL == nil) {
                            openURL(url)
                        }
                    }
                }
            }
        }
        .padding(12)
        .gothicCard(borderOpacity: isBooked ? 0.15 : 0.28)
    }

    private func actionButton(title: String, icon: String, filled: Bool, action: @escaping () -> Void) -> some View {
        Button {
            Haptics.tap()
            action()
        } label: {
            Label(title, systemImage: icon)
                .font(.caption.weight(.semibold))
                .padding(.horizontal, 10)
                .padding(.vertical, 7)
                .frame(maxWidth: .infinity)
                .background(filled ? Theme.cityColor(day.city) : Theme.cityColor(day.city).opacity(0.12))
                .foregroundStyle(filled ? .white : Theme.cityColor(day.city))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
        .buttonStyle(.pressable)
    }
}

#Preview {
    BookingsTabView(day: TripData.allDays[13])
}
