import SwiftUI

struct CalendarView: View {
    private let year = 2026
    private let month = 9
    private let weekdaySymbols = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]

    private var cells: [Int?] {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2 // Monday

        var comps = DateComponents()
        comps.year = year
        comps.month = month
        comps.day = 1
        guard let firstOfMonth = calendar.date(from: comps),
              let range = calendar.range(of: .day, in: .month, for: firstOfMonth) else {
            return []
        }

        let weekday = calendar.component(.weekday, from: firstOfMonth)
        let mondayFirstIndex = (weekday + 5) % 7
        var result: [Int?] = Array(repeating: nil, count: mondayFirstIndex)
        result.append(contentsOf: range.map { $0 })
        return result
    }

    /// Число месяца "сегодня", если прямо сейчас идёт сентябрь 2026 — иначе nil.
    /// Используется для подсветки текущего дня и карточки быстрого перехода.
    private var todayDayOfMonth: Int? {
        let comps = Calendar.current.dateComponents([.year, .month, .day], from: .now)
        return (comps.year == year && comps.month == month) ? comps.day : nil
    }

    private var weeks: [[Int?]] {
        stride(from: 0, to: cells.count, by: 7).map { start in
            let end = min(start + 7, cells.count)
            var week = Array(cells[start..<end])
            while week.count < 7 { week.append(nil) }
            return week
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    hero

                    if let today = TripData.day(for: .now) {
                        todayCard(today)
                    }

                    GothicDivider()
                        .frame(maxWidth: .infinity)

                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                        ForEach(weekdaySymbols, id: \.self) { symbol in
                            Text(symbol)
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(Theme.inkSecondary)
                                .frame(maxWidth: .infinity)
                        }

                        ForEach(Array(weeks.enumerated()), id: \.offset) { _, week in
                            ForEach(Array(week.enumerated()), id: \.offset) { _, dayValue in
                                dayCell(dayValue)
                            }
                        }
                    }
                    .padding(.horizontal)

                    legend
                        .padding(.horizontal)

                    Spacer(minLength: 20)
                }
                .padding(.bottom, 12)
                .readableWidth()
            }
            .background(Theme.paper.ignoresSafeArea())
            .toolbarBackground(.hidden, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
    }

    private var hero: some View {
        ZStack(alignment: .bottomLeading) {
            NightCityScene()
                .frame(height: 190)

            VStack(alignment: .leading, spacing: 4) {
                Theme.eyebrow("Путеводитель для двоих")
                    .foregroundStyle(Theme.goldLight)
                Text("Лондон → Лион")
                    .font(Theme.serifLargeTitle)
                    .foregroundStyle(.white)
                Text("22 дня · 05–26 сентября 2026")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.white.opacity(0.9))
            }
            .shadow(color: .black.opacity(0.35), radius: 6, y: 2)
            .padding(16)
        }
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(Theme.gold.opacity(0.55), lineWidth: 1.5)
        )
        .padding(.horizontal)
        .padding(.top, 4)
    }

    private var legend: some View {
        VStack(alignment: .leading, spacing: 10) {
            Theme.eyebrow("Точки маршрута")
                .foregroundStyle(Theme.inkSecondary)

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), spacing: 8)], alignment: .leading, spacing: 8) {
                ForEach(orderedCities, id: \.self) { city in
                    HStack(spacing: 6) {
                        Circle().fill(Theme.cityColor(city)).frame(width: 10, height: 10)
                        Text(city.name)
                            .font(.caption)
                            .foregroundStyle(Theme.ink)
                            .lineLimit(1)
                    }
                }
            }
        }
        .padding(14)
        .gothicCard()
    }

    private var orderedCities: [City] {
        var seen: Set<City> = []
        var result: [City] = []
        for day in TripData.allDays where !seen.contains(day.city) {
            seen.insert(day.city)
            result.append(day.city)
        }
        return result
    }

    /// Быстрый переход к текущему дню поездки — появляется только с 5 по 27 сентября 2026.
    private func todayCard(_ today: TripDay) -> some View {
        NavigationLink {
            DayDetailView(day: today)
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "location.fill")
                    .frame(width: 34, height: 34)
                    .background(Theme.cityColor(today.city).opacity(0.16))
                    .foregroundStyle(Theme.cityColor(today.city))
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Theme.cityColor(today.city).opacity(0.4), lineWidth: 1))

                VStack(alignment: .leading, spacing: 2) {
                    Theme.eyebrow("Сегодня")
                        .foregroundStyle(Theme.gold)
                    Text("День \(today.id) · \(today.city.name)")
                        .font(Theme.serifHeadline)
                        .foregroundStyle(Theme.ink)
                    Text(today.subtitle)
                        .font(.caption)
                        .foregroundStyle(Theme.inkSecondary)
                }

                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Theme.inkSecondary.opacity(0.6))
            }
            .padding(12)
            .gothicCard(borderOpacity: 0.5)
        }
        .buttonStyle(.plain)
        .simultaneousGesture(TapGesture().onEnded { Haptics.tap() })
        .padding(.horizontal)
    }

    @ViewBuilder
    private func dayCell(_ dayValue: Int?) -> some View {
        if let dayValue, let trip = TripData.day(forDayOfMonth: dayValue) {
            let isToday = dayValue == todayDayOfMonth
            NavigationLink {
                DayDetailView(day: trip)
            } label: {
                VStack(spacing: 2) {
                    Text("\(dayValue)")
                        .font(Theme.serif(15, weight: .bold))
                        .foregroundStyle(.white)
                    Text(trip.city.name)
                        .font(.system(size: 9, weight: .semibold))
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                        .foregroundStyle(.white.opacity(0.9))
                }
                .frame(maxWidth: .infinity, minHeight: 54)
                .background(Theme.cityGradient(trip.city))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(
                            isToday ? Color.white : Theme.goldLight.opacity(0.55),
                            lineWidth: isToday ? 2.5 : 1
                        )
                )
                .shadow(color: Theme.cityColor(trip.city).opacity(0.35), radius: 4, y: 2)
            }
            .buttonStyle(.plain)
            .simultaneousGesture(TapGesture().onEnded { Haptics.tap() })
        } else if let dayValue {
            Text("\(dayValue)")
                .font(.body)
                .foregroundStyle(Theme.inkSecondary.opacity(0.6))
                .frame(maxWidth: .infinity, minHeight: 54)
                .background(Theme.card.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        } else {
            Color.clear.frame(maxWidth: .infinity, minHeight: 54)
        }
    }
}

#Preview {
    CalendarView()
}
