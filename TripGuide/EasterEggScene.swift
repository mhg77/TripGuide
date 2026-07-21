import SwiftUI

/// Скрытая анимация-шутка, которая всплывает поверх ВСЕГО экрана по тройному тапу на
/// вкладке «План» — косой дождь из фотореалистичного предмета, привязанного к конкретному
/// дню (у каждого из 23 дней путеводителя свой предмет).
///
/// Пять тем — логотип Top Gear, Мэри Поппинс, силуэт Микки Мауса, лампа Pixar и олимпийские
/// кольца — заменены на generic-эквиваленты (секундомер с гоночным флагом, зонт с саквояжем,
/// карусельная лошадка, настольная лампа, медаль со снежинкой), потому что оригиналы —
/// охраняемые товарные знаки/персонажи, а не просто предметы.
nonisolated enum RainObject: CaseIterable {
    case crown          // День 1 — Корона Елизаветы II
    case bigBen         // День 2 — Биг-Бен
    case `guard`        // День 3 — Королевский гвардеец
    case snitch         // День 4 — Гарри Поттер
    case motorsport     // День 5 — Паб Кларксона (Top Gear → секундомер с гоночным флагом)
    case bus            // День 6 — Двухэтажный автобус
    case poppins        // День 7 — Мэри Поппинс → зонт и саквояж
    case phoneBooth     // День 8 — Телефонная будка
    case eiffel         // День 9 — Эйфелева башня
    case baguette       // День 10 — Багеты
    case carousel       // День 11 — Микки Маус → карусельная лошадка
    case deskLamp       // День 12 — Лампа Pixar → настольная лампа
    case belfry         // День 13 — Колокольня в Брюгге
    case wineBottle     // День 14 — Бутылка вина
    case annecyPalace   // День 15 — Дворец в Анси
    case medal          // День 16 — Олимпийские кольца → медаль со снежинкой
    case glacier        // День 17 — Ледник
    case snowboard      // День 18 — Сноуборд
    case skis           // День 19 — Лыжи
    case snowmobile     // День 20 — Снегоход
    case bathrobe       // День 21 — Банный халат
    case venik           // День 22 — Веник для бани
    case clapper        // День 23 — Кино-хлопушка

    static func forDay(id: Int) -> RainObject? {
        switch id {
        case 1: return .crown
        case 2: return .bigBen
        case 3: return .`guard`
        case 4: return .snitch
        case 5: return .motorsport
        case 6: return .bus
        case 7: return .poppins
        case 8: return .phoneBooth
        case 9: return .eiffel
        case 10: return .baguette
        case 11: return .carousel
        case 12: return .deskLamp
        case 13: return .belfry
        case 14: return .wineBottle
        case 15: return .annecyPalace
        case 16: return .medal
        case 17: return .glacier
        case 18: return .snowboard
        case 19: return .skis
        case 20: return .snowmobile
        case 21: return .bathrobe
        case 22: return .venik
        case 23: return .clapper
        default: return nil
        }
    }

    /// Имя изображения в Assets.xcassets/Egg*.imageset.
    var imageName: String {
        switch self {
        case .crown: return "EggCrown"
        case .bigBen: return "EggBigBen"
        case .`guard`: return "EggGuard"
        case .snitch: return "EggSnitch"
        case .motorsport: return "EggMotorsport"
        case .bus: return "EggBus"
        case .poppins: return "EggPoppins"
        case .phoneBooth: return "EggPhoneBooth"
        case .eiffel: return "EggEiffel"
        case .baguette: return "EggBaguette"
        case .carousel: return "EggCarousel"
        case .deskLamp: return "EggDeskLamp"
        case .belfry: return "EggBelfry"
        case .wineBottle: return "EggWineBottle"
        case .annecyPalace: return "EggAnnecyPalace"
        case .medal: return "EggMedal"
        case .glacier: return "EggGlacier"
        case .snowboard: return "EggSnowboard"
        case .skis: return "EggSkis"
        case .snowmobile: return "EggSnowmobile"
        case .bathrobe: return "EggBathrobe"
        case .venik: return "EggVenik"
        case .clapper: return "EggClapper"
        }
    }

    /// Все спрайты приведены к единому квадратному холсту (1024×1024, предмет центрирован
    /// и занимает бо́льшую часть кадра) — поэтому пропорция у всех одинаковая, 1:1.
    var aspect: CGFloat { 1.0 }
}

struct EasterEggScene: View {
    let object: RainObject

    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let t = timeline.date.timeIntervalSinceReferenceDate
                EasterEggArt.rain(&context, size, t, object: object)
            }
        }
        .drawingGroup()
    }
}

private enum EasterEggArt {

    private static func frac(_ x: Double) -> Double { x - floor(x) }

    /// Простой детерминированный псевдослучайный хэш — на каждый индекс частицы даёт
    /// одно и то же число от 0 до 1 в любом кадре, без хранения состояния.
    private static func hash(_ i: Int) -> Double {
        let x = sin(Double(i) * 12.9898 + 78.233) * 43758.5453
        return x - floor(x)
    }

    /// Рисует фотореалистичный спрайт из Assets.xcassets с заданным центром, высотой
    /// (ширина считается из aspect = ширина/высота исходного кадра), поворотом и прозрачностью.
    private static func drawSprite(
        _ context: inout GraphicsContext,
        name: String,
        center: CGPoint,
        height: CGFloat,
        aspect: CGFloat,
        rotation: Angle = .zero,
        opacity: Double = 1
    ) {
        guard opacity > 0.01 else { return }
        let width = height * aspect
        context.drawLayer { layer in
            layer.opacity = opacity
            layer.translateBy(x: center.x, y: center.y)
            layer.rotate(by: rotation)
            layer.draw(Image(name), in: CGRect(x: -width / 2, y: -height / 2, width: width, height: height))
        }
    }

    // MARK: - Косой дождь из предмета через весь экран

    static func rain(_ context: inout GraphicsContext, _ size: CGSize, _ t: Double, object: RainObject) {
        let count = 14

        for i in 0..<count {
            let h1 = hash(i * 7 + 1)    // скорость падения
            let h2 = hash(i * 13 + 3)   // сдвиг фазы во времени (чтобы не падали синхронно)
            let h3 = hash(i * 19 + 5)   // масштаб и скорость вращения
            let h4 = hash(i * 29 + 11)  // косой снос по горизонтали (ветер)
            let h5 = hash(i * 37 + 17)  // джиттер полосы

            let speed = 0.11 + h1 * 0.09
            let progress = frac(t * speed + h2)
            let lane = (Double(i) + h5) / Double(count)
            let drift = (h4 - 0.5) * 0.7

            let y = CGFloat(progress) * (size.height * 1.3) - size.height * 0.15
            let x = CGFloat(lane) * size.width + CGFloat(progress * drift) * size.width * 0.4

            let edgeFade = min(progress, 1 - progress) * 10
            let opacity = max(0, min(1, edgeFade))

            let baseHeight: CGFloat = 64 + CGFloat(h3) * 56
            let spinSpeed = 0.4 + h3 * 0.9
            let spinSign: Double = h1 > 0.5 ? 1 : -1
            let rotation = t * spinSpeed * spinSign + h2 * (.pi * 2)

            drawSprite(
                &context, name: object.imageName,
                center: CGPoint(x: x, y: y),
                height: baseHeight, aspect: object.aspect,
                rotation: .radians(rotation), opacity: opacity
            )
        }
    }
}
