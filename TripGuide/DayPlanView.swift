import SwiftUI

struct DayPlanView: View {
    let day: TripDay
    var onSwipeNext: (() -> Void)? = nil
    var onSwipePrevious: (() -> Void)? = nil

    /// Пасхалка теперь не отдельная карточка, а скрытая анимация: тройной тап по
    /// экрану «План» показывает её ненадолго поверх контента, если для дня она есть.
    @State private var showEasterEgg = false
    private var eggObject: RainObject? { RainObject.forDay(id: day.id) }

    private var cityColor: Color { Theme.cityColor(day.city) }

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    header

                    if let intro = day.intro {
                        infoCard(text: intro, color: Theme.info, icon: "info.circle.fill", title: "Об этом месте")
                    }

                    if let todayFocus = day.todayFocus {
                        HStack(alignment: .top, spacing: 8) {
                            Image(systemName: "star.fill")
                                .foregroundStyle(Theme.sunset)
                            Text("Сегодня: \(todayFocus)")
                                .font(.subheadline.weight(.medium))
                                .foregroundStyle(Theme.ink)
                        }
                        .padding(.horizontal)
                    }

                    if let warning = day.warning {
                        infoCard(text: warning, color: Theme.warning, icon: "exclamationmark.triangle.fill", title: "Важно")
                    }

                    VStack(spacing: 0) {
                        ForEach(day.blocks) { block in
                            blockRow(block)
                            if block.id != day.blocks.last?.id {
                                Divider().padding(.leading, 44)
                            }
                        }
                    }
                    .gothicCard()
                    .padding(.horizontal)

                    if day.fact != nil {
                        GothicDivider(color: cityColor)
                            .frame(maxWidth: .infinity)
                    }

                    if let fact = day.fact {
                        infoCard(text: fact, color: Theme.fact, icon: "sparkles", title: "Знали ли вы?")
                    }
                }
                .padding(.bottom, 24)
                .readableWidth()
            }
            .background(Theme.paper.ignoresSafeArea())
            .daySwipeNavigation(onNext: { onSwipeNext?() }, onPrevious: { onSwipePrevious?() })
            .contentShape(Rectangle())
            .onTapGesture(count: 3) { triggerEasterEgg() }

            if showEasterEgg, let object = eggObject {
                easterEggOverlay(object: object)
            }
        }
    }

    private func triggerEasterEgg() {
        guard eggObject != nil, !showEasterEgg else { return }
        Haptics.success()
        withAnimation(.easeOut(duration: 0.3)) { showEasterEgg = true }
    }

    private var header: some View {
        ZStack(alignment: .bottomLeading) {
            NightCityScene(city: day.city)
                .frame(height: 132)

            VStack(alignment: .leading, spacing: 3) {
                Text(day.city.name)
                    .font(Theme.serifTitle)
                    .foregroundStyle(.white)
                Text("\(day.dateLabel) · \(day.subtitle)")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.white.opacity(0.92))
            }
            .shadow(color: .black.opacity(0.35), radius: 5, y: 2)
            .padding(14)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(
            Rectangle()
                .fill(Theme.gold.opacity(0.5))
                .frame(height: 1.5),
            alignment: .bottom
        )
    }

    private func blockRow(_ block: PlanBlock) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: block.icon)
                .frame(width: 26, height: 26)
                .background(cityColor.opacity(0.14))
                .foregroundStyle(cityColor)
                .clipShape(Circle())
                .overlay(Circle().stroke(cityColor.opacity(0.3), lineWidth: 1))
            VStack(alignment: .leading, spacing: 2) {
                Text(block.label)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Theme.ink)
                Text(block.text)
                    .font(.subheadline)
                    .foregroundStyle(Theme.ink.opacity(0.85))
            }
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
    }

    private func infoCard(text: String, color: Color, icon: String, title: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .foregroundStyle(color)
                Text(title)
                    .font(.caption.weight(.bold))
                    .foregroundStyle(color)
            }
            Text(text)
                .font(.subheadline)
                .foregroundStyle(Theme.ink.opacity(0.9))
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(color.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(color.opacity(0.25), lineWidth: 1)
        )
        .padding(.horizontal)
    }

    /// Скрытая пасхалка: не окошко в углу, а анимация через весь экран — косой дождь
    /// из предметов, привязанных к дню. Появляется поверх контента на тройной тап,
    /// гаснет сама, либо закрывается тапом.
    private func easterEggOverlay(object: RainObject) -> some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()

            EasterEggScene(object: object)
                .ignoresSafeArea()
                .allowsHitTesting(false)
                // Текст пасхалки остался в данных дня (TripData.swift) — используем его
                // как подпись для VoiceOver, хотя на экране показывается только анимация.
                .accessibilityLabel(day.easterEggText ?? "Пасхалка")
        }
        .contentShape(Rectangle())
        .onTapGesture { triggerEarlyDismiss() }
        // Автоскрытие через 4 секунды. `.task` отменяется сам, как только оверлей
        // исчезает (ранний тап или уход с экрана) — в отличие от asyncAfter.
        .task {
            try? await Task.sleep(for: .seconds(4))
            guard !Task.isCancelled else { return }
            withAnimation(.easeIn(duration: 0.4)) { showEasterEgg = false }
        }
        .transition(.opacity)
        .zIndex(1)
    }

    private func triggerEarlyDismiss() {
        withAnimation(.easeIn(duration: 0.25)) { showEasterEgg = false }
    }
}

#Preview {
    NavigationStack {
        DayPlanView(day: TripData.allDays[13])
    }
}
