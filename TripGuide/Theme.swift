import SwiftUI

/// Тёмная, но не чёрная палитра приложения — благородная "ясная европейская ночь"
/// (глубокий сапфирово-грифельный небосвод) с тёплыми золотыми акцентами.
enum Theme {
    // Фон и карточки — глубокая ночная синева, а не системный чёрный.
    static let paper = Color(red: 0.055, green: 0.075, blue: 0.135)
    static let card = Color(red: 0.11, green: 0.14, blue: 0.22)

    // Текст — тёплая слоновая кость и приглушённый сумеречно-лавандовый, не чистый белый/серый.
    static let ink = Color(red: 0.95, green: 0.94, blue: 0.91)
    static let inkSecondary = Color(red: 0.63, green: 0.66, blue: 0.77)

    // Основной акцент — закатный коралл (соответствует AccentColor и иконке).
    static let sunset = Color(red: 0.95, green: 0.55, blue: 0.32)

    static let warning = Color(red: 0.95, green: 0.44, blue: 0.40)
    static let success = Color(red: 0.45, green: 0.78, blue: 0.52)
    static let info = Color(red: 0.48, green: 0.70, blue: 0.92)
    static let fact = Color(red: 0.79, green: 0.62, blue: 0.93)

    // Готический декоративный акцент — старое золото и бургунди, как в манускриптах и витражах.
    static let gold = Color(red: 0.80, green: 0.65, blue: 0.38)
    static let goldLight = Color(red: 0.93, green: 0.83, blue: 0.60)
    static let wine = Color(red: 0.86, green: 0.40, blue: 0.44)

    /// Цвет-акцент для каждого города/точки маршрута — оживляет календарь и заголовки дней.
    static func cityColor(_ city: City) -> Color {
        switch city {
        case .london: return Color(red: 0.45, green: 0.60, blue: 0.85)
        case .paris: return Color(red: 0.92, green: 0.55, blue: 0.62)
        case .disneyland: return Color(red: 0.74, green: 0.58, blue: 0.92)
        case .beaune: return Color(red: 0.85, green: 0.42, blue: 0.46)
        case .annecy: return Color(red: 0.38, green: 0.80, blue: 0.86)
        case .chamonix: return Color(red: 0.58, green: 0.65, blue: 0.88)
        case .lesArcs: return Color(red: 0.46, green: 0.80, blue: 0.60)
        case .turin: return Color(red: 0.82, green: 0.52, blue: 0.42)
        case .lyon: return Color(red: 0.90, green: 0.74, blue: 0.38)
        }
    }

    static func cityGradient(_ city: City) -> LinearGradient {
        let base = cityColor(city)
        return LinearGradient(
            colors: [base, base.opacity(0.75)],
            startPoint: .topLeading, endPoint: .bottomTrailing
        )
    }

    // MARK: - Типографика
    // Заголовки — системный serif (New York), лёгкий отсыл к старым европейским путеводителям
    // и витражным подписям, при этом остаётся полностью читаемым.
    static func serif(_ size: CGFloat, weight: Font.Weight = .bold) -> Font {
        .system(size: size, weight: weight, design: .serif)
    }

    static var serifLargeTitle: Font { serif(28, weight: .bold) }
    static var serifTitle: Font { serif(21, weight: .bold) }
    static var serifHeadline: Font { serif(17, weight: .semibold) }

    /// Небольшая надпись вразрядку — как подпись под гравюрой.
    static func eyebrow(_ text: String) -> some View {
        Text(text.uppercased())
            .font(.system(size: 11, weight: .bold, design: .serif))
            .tracking(2.2)
    }
}

// MARK: - Готические декоративные элементы

/// Орнаментальный разделитель секций — линия / ромб / линия, как на форзаце старой книги.
struct GothicDivider: View {
    var color: Color = Theme.gold

    var body: some View {
        HStack(spacing: 8) {
            line
            Image(systemName: "diamond.fill")
                .font(.system(size: 6))
                .foregroundStyle(color)
            line
        }
        .padding(.horizontal, 40)
        .opacity(0.55)
    }

    private var line: some View {
        Rectangle()
            .fill(color)
            .frame(height: 1)
    }
}

/// Карточка с тонкой золотой окантовкой и мягкой тенью — единый стиль для всех блоков приложения.
struct GothicCardStyle: ViewModifier {
    var cornerRadius: CGFloat = 16
    var borderOpacity: Double = 0.32

    func body(content: Content) -> some View {
        content
            .background(Theme.card)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(Theme.gold.opacity(borderOpacity), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.45), radius: 10, y: 4)
    }
}

extension View {
    func gothicCard(cornerRadius: CGFloat = 16, borderOpacity: Double = 0.28) -> some View {
        modifier(GothicCardStyle(cornerRadius: cornerRadius, borderOpacity: borderOpacity))
    }
}

/// Кнопка с лёгким "нажатием" — приятнее и дружелюбнее стандартного плоского тапа.
struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .opacity(configuration.isPressed ? 0.88 : 1)
            .animation(.spring(response: 0.28, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == PressableButtonStyle {
    static var pressable: PressableButtonStyle { PressableButtonStyle() }
}

/// На iPad (широкий, "regular" горизонтальный size class) ограничивает ширину колонки
/// с текстом и карточками, чтобы строки не растягивались во весь экран — на iPhone
/// (compact size class, в т.ч. Slide Over на iPad) работает как раньше, без изменений.
struct ReadableWidthModifier: ViewModifier {
    @Environment(\.horizontalSizeClass) private var hSizeClass
    var maxWidth: CGFloat = 680

    func body(content: Content) -> some View {
        HStack(spacing: 0) {
            Spacer(minLength: 0)
            content.frame(maxWidth: hSizeClass == .regular ? maxWidth : .infinity)
            Spacer(minLength: 0)
        }
    }
}

extension View {
    func readableWidth(_ maxWidth: CGFloat = 680) -> some View {
        modifier(ReadableWidthModifier(maxWidth: maxWidth))
    }
}

/// Свайп влево/вправо для перехода к соседнему дню поездки. Требует в основном
/// горизонтального жеста, чтобы не мешать обычному вертикальному скроллу экрана.
struct DaySwipeModifier: ViewModifier {
    let onNext: () -> Void
    let onPrevious: () -> Void

    func body(content: Content) -> some View {
        // Именно simultaneousGesture: обычный .gesture() на ScrollView почти всегда
        // проигрывает pan-жесту скролла, и свайп срабатывал только при идеально
        // горизонтальном старте. Параллельное распознавание работает по всей площади,
        // а от ложных срабатываний при скролле защищает проверка направления ниже.
        content.simultaneousGesture(
            DragGesture(minimumDistance: 24)
                .onEnded { value in
                    let horizontal = value.translation.width
                    let vertical = value.translation.height
                    // Жест должен быть уверенно горизонтальным...
                    guard abs(horizontal) > abs(vertical) * 1.2 else { return }
                    // ...и либо достаточно длинным, либо быстрым "фликом"
                    // (predictedEndTranslation учитывает скорость в момент отпускания).
                    guard abs(horizontal) > 48 || abs(value.predictedEndTranslation.width) > 110 else { return }
                    if horizontal < 0 {
                        onNext()
                    } else {
                        onPrevious()
                    }
                }
        )
    }
}

extension View {
    func daySwipeNavigation(onNext: @escaping () -> Void, onPrevious: @escaping () -> Void) -> some View {
        modifier(DaySwipeModifier(onNext: onNext, onPrevious: onPrevious))
    }
}
