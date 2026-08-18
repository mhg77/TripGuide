import SwiftUI

/// Фотореалистичный ночной фон для каждого города поездки — настоящий кадр (не рисунок),
/// оживлённый лёгкой процедурной анимацией погоды и света поверх: дождь над Лондоном,
/// мерцание над Парижем, салют над Диснейлендом и так далее. Анимация рисуется в Canvas
/// через TimelineView и не хранит собственного состояния — лёгкая и не "утекает" по памяти.
struct NightCityScene: View {
    /// nil — сборный "обзорный" пейзаж для календаря (вся поездка сразу).
    var city: City?

    private var imageName: String {
        city?.nightImageName ?? "NightOverview"
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()

                LinearGradient(
                    colors: [.black.opacity(0), .black.opacity(0.10), .black.opacity(0.48)],
                    startPoint: .top, endPoint: .bottom
                )

                TimelineView(.animation) { timeline in
                    Canvas { context, size in
                        let t = timeline.date.timeIntervalSinceReferenceDate
                        NightArt.weather(for: city, &context, size, t)
                    }
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .clipped()
        .drawingGroup()
    }
}

// MARK: - Художник: лёгкая процедурная погода и свет поверх фотографий

private enum NightArt {

    static func weather(for city: City?, _ context: inout GraphicsContext, _ size: CGSize, _ t: Double) {
        guard let city else {
            // Обзорный пейзаж календаря — нейтральное звёздное мерцание.
            sparkleField(&context, size, t: t, count: 20, color: .white, minY: 0.05, maxY: 0.42)
            return
        }
        switch city {
        case .london:
            lightning(&context, size, t: t)
            rain(&context, size, t: t, count: 46, color: .white)
        case .paris:
            sparkleField(&context, size, t: t, count: 24, color: Theme.goldLight, minY: 0.15, maxY: 0.78)
        case .disneyland:
            fireworks(&context, size, t: t, colors: [Theme.gold, Color(red: 0.85, green: 0.4, blue: 0.55), Color(red: 0.45, green: 0.75, blue: 0.85)])
            sparkleField(&context, size, t: t, count: 10, color: .white, minY: 0.05, maxY: 0.4)
        case .beaune:
            sparkleField(&context, size, t: t, count: 16, color: Theme.gold, minY: 0.55, maxY: 0.9)
        case .annecy:
            ripples(&context, size, t: t, waterY: size.height * 0.80, color: .white)
            sparkleField(&context, size, t: t, count: 10, color: .white, minY: 0.05, maxY: 0.4)
        case .chamonix:
            snow(&context, size, t: t, count: 22, color: .white)
        case .lesArcs:
            snow(&context, size, t: t, count: 42, color: .white)
            sparkleField(&context, size, t: t, count: 12, color: Theme.gold, minY: 0.4, maxY: 0.75)
        case .preSaintDidier:
            steam(&context, size, t: t, originX: size.width * 0.35, originY: size.height * 0.74, color: .white)
            steam(&context, size, t: t, originX: size.width * 0.62, originY: size.height * 0.72, color: .white)
        case .lyon:
            sparkleField(&context, size, t: t, count: 16, color: Theme.goldLight, minY: 0.25, maxY: 0.62)
        }
    }

    private static func frac(_ x: Double) -> Double { x - floor(x) }

    // MARK: Частицы

    /// Рассыпанные по кадру мерцающие огоньки — заменяет привязку к силуэтам конкретных зданий,
    /// естественно смотрится поверх любой фотографии (окна, гирлянды, звёзды).
    static func sparkleField(_ context: inout GraphicsContext, _ size: CGSize, t: Double, count: Int, color: Color, minY: Double = 0, maxY: Double = 1) {
        for i in 0..<count {
            let seed = Double(i) * 12.9898 + 4.5
            let fx = frac(sin(seed) * 43758.5453)
            let fy = minY + frac(sin(seed * 1.7 + 3.1) * 12345.678) * (maxY - minY)
            let phase = frac(sin(seed * 2.3)) * .pi * 2
            let speed = 0.9 + frac(sin(seed * 4.1)) * 1.8
            let twinkle = pow(abs(sin(t * speed + phase)), 3)
            guard twinkle > 0.12 else { continue }
            let r: CGFloat = 1.2 + CGFloat(frac(sin(seed * 5.7))) * 1.3
            let cx = CGFloat(fx) * size.width
            let cy = CGFloat(fy) * size.height
            var dot = Path()
            dot.addEllipse(in: CGRect(x: cx - r, y: cy - r, width: r * 2, height: r * 2))
            context.fill(dot, with: .color(color.opacity(twinkle)))
        }
    }

    static func rain(_ context: inout GraphicsContext, _ size: CGSize, t: Double, count: Int = 40, color: Color) {
        for i in 0..<count {
            let seed = Double(i)
            let fx = frac(sin(seed * 7.13) * 5423.7)
            let speed = 1.3 + frac(sin(seed * 3.3)) * 0.8
            let phase = frac(sin(seed * 9.1))
            let y0 = (t * (0.9 + speed) + phase).truncatingRemainder(dividingBy: 1.15) - 0.1
            let x = CGFloat(fx) * size.width
            let y = CGFloat(y0) * size.height
            let len: CGFloat = 10 + CGFloat(frac(sin(seed * 4.4))) * 8
            var drop = Path()
            drop.move(to: CGPoint(x: x, y: y))
            drop.addLine(to: CGPoint(x: x - 3, y: y + len))
            context.stroke(drop, with: .color(color.opacity(0.35)), lineWidth: 1.2)
        }
    }

    static func lightning(_ context: inout GraphicsContext, _ size: CGSize, t: Double) {
        let cycle = t.truncatingRemainder(dividingBy: 6.5)
        guard cycle < 0.12 else { return }
        let flash = 1 - (cycle / 0.12)
        let rect = Path(CGRect(origin: .zero, size: size))
        context.fill(rect, with: .color(.white.opacity(0.16 * flash)))
    }

    static func snow(_ context: inout GraphicsContext, _ size: CGSize, t: Double, count: Int = 34, color: Color = .white) {
        for i in 0..<count {
            let seed = Double(i) * 3.77
            let fx = frac(sin(seed * 6.31) * 4321.1)
            let speed = 0.12 + frac(sin(seed * 2.1)) * 0.10
            let phase = frac(sin(seed * 8.8))
            let y0 = (t * speed + phase).truncatingRemainder(dividingBy: 1.1) - 0.05
            let drift = sin(t * 0.6 + seed) * 10
            let x = CGFloat(fx) * size.width + CGFloat(drift)
            let y = CGFloat(y0) * size.height
            let r: CGFloat = 1.4 + CGFloat(frac(sin(seed * 5.5))) * 1.6
            var flake = Path()
            flake.addEllipse(in: CGRect(x: x - r, y: y - r, width: r * 2, height: r * 2))
            context.fill(flake, with: .color(color.opacity(0.75)))
        }
    }

    static func fireworks(_ context: inout GraphicsContext, _ size: CGSize, t: Double, colors: [Color]) {
        let burstCount = 3
        for b in 0..<burstCount {
            let seed = Double(b) * 17.3
            let cycle = 3.2
            let localT = (t * 0.6 + seed).truncatingRemainder(dividingBy: cycle)
            guard localT < 1.3 else { continue }
            let phase = localT / 1.3
            let cx = size.width * CGFloat(0.22 + 0.28 * Double(b))
            let cy = size.height * CGFloat(0.18 + 0.08 * frac(sin(seed)))
            let color = colors[b % colors.count]
            let particles = 14
            let radius = CGFloat(phase) * size.width * 0.16
            let fade = 1 - phase
            for p in 0..<particles {
                let angle = (Double(p) / Double(particles)) * 2 * .pi
                let px = cx + radius * CGFloat(cos(angle))
                let py = cy + radius * CGFloat(sin(angle)) * 0.85 + CGFloat(phase * phase) * 14
                var dot = Path()
                let r: CGFloat = 1.8
                dot.addEllipse(in: CGRect(x: px - r, y: py - r, width: r * 2, height: r * 2))
                context.fill(dot, with: .color(color.opacity(Double(fade) * 0.9)))
            }
        }
    }

    static func steam(_ context: inout GraphicsContext, _ size: CGSize, t: Double, originX: CGFloat, originY: CGFloat, color: Color) {
        for i in 0..<10 {
            let seed = Double(i)
            let speed = 0.10 + frac(sin(seed * 3.1)) * 0.08
            let phase = frac(sin(seed * 7.7))
            let life = (t * speed + phase).truncatingRemainder(dividingBy: 1.0)
            let drift = sin(t * 0.5 + seed) * 8
            let x = originX + CGFloat(drift) + CGFloat(seed - 5) * 6
            let y = originY - CGFloat(life) * 70
            let r: CGFloat = 6 + CGFloat(life) * 10
            let opacity = (1 - life) * 0.16
            var puff = Path()
            puff.addEllipse(in: CGRect(x: x - r, y: y - r, width: r * 2, height: r * 2))
            context.fill(puff, with: .color(color.opacity(opacity)))
        }
    }

    static func ripples(_ context: inout GraphicsContext, _ size: CGSize, t: Double, waterY: CGFloat, color: Color) {
        for i in 0..<3 {
            let seed = Double(i) * 2.2
            let cycle = 3.5
            let phase = (t + seed).truncatingRemainder(dividingBy: cycle) / cycle
            let cx = size.width * CGFloat(0.3 + 0.22 * Double(i))
            let r = CGFloat(phase) * 34
            let opacity = (1 - phase) * 0.28
            let ring = Path(ellipseIn: CGRect(x: cx - r, y: waterY - r * 0.32, width: r * 2, height: r * 0.64))
            context.stroke(ring, with: .color(color.opacity(opacity)), lineWidth: 1)
        }
    }
}
