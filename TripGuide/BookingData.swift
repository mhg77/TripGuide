import Foundation

/// Билеты, отели и рестораны с бронью — по номеру дня (TripDay.id).
/// Официальные ссылки указаны только там, где сайт точно известен (крупные операторы).
/// Для отелей и небольших ресторанов — поиск на карте / Booking.com, без выдуманных ссылок.
enum BookingData {
    static let items: [Int: [BookingItem]] = [

        // День 1 — Лондон, прилёт
        1: [
            BookingItem(
                name: "London Eye", kind: .ticket,
                note: "€65–95 за двоих, стандартный слот. Fast Track — доплата ~€45–55.",
                officialURLString: "https://www.londoneye.com/tickets-and-prices/", officialLabel: "Купить билет",
                mapsQuery: "London Eye"
            ),
            BookingItem(
                name: "Henrietta Experimental ★★★★", kind: .hotel,
                note: "€175–260/ночь · 2 мин до Savoy Theatre · 8 ночей",
                mapsQuery: "Henrietta Experimental Hotel London",
                bookingComQuery: "Henrietta Experimental Hotel Covent Garden London"
            ),
            BookingItem(
                name: "The Z Hotel Covent Garden ★★★", kind: .hotel,
                note: "€100–200/ночь · компактный, бюджетнее",
                mapsQuery: "The Z Hotel Covent Garden London",
                bookingComQuery: "The Z Hotel Covent Garden London"
            ),
        ],

        // День 2 — Вестминстер
        2: [
            BookingItem(
                name: "Вестминстерское аббатство", kind: .ticket,
                note: "€65–70 за двоих, вход строго по тайм-слоту.",
                officialURLString: "https://tickets.westminster-abbey.org/home/index", officialLabel: "Купить билет",
                mapsQuery: "Westminster Abbey London"
            ),
        ],

        // День 3 — Тауэр · Гринвич
        3: [
            BookingItem(
                name: "Тауэр Лондона", kind: .ticket,
                note: "€65–80 за двоих по тайм-слоту.",
                officialURLString: "https://www.hrp.org.uk/tower-of-london/visit/tickets-and-prices/", officialLabel: "Купить билет",
                mapsQuery: "Tower of London"
            ),
            BookingItem(
                name: "Кораблик Тауэр → Гринвич", kind: .ticket,
                note: "€28–40 за двоих. С онлайн-билетом посадка почти сразу.",
                officialURLString: "https://www.cityexperiences.com/london/city-cruises/", officialLabel: "Купить билет",
                mapsQuery: "City Cruises Tower Pier London"
            ),
            BookingItem(
                name: "Королевская обсерватория + Cutty Sark", kind: .ticket,
                note: "€46–52 за двоих по тайм-слоту.",
                officialURLString: "https://www.rmg.co.uk/plan-your-visit/tickets-prices", officialLabel: "Купить билет",
                mapsQuery: "Royal Observatory Greenwich"
            ),
            BookingItem(
                name: "The Grapes, Лаймхаус", kind: .restaurant,
                note: "Паб Иэна Маккеллена на набережной Темзы — столы не бронируют, приходите заранее. По понедельникам с 20:00 паб-квиз.",
                mapsQuery: "The Grapes Limehouse London"
            ),
        ],

        // День 4 — Harry Potter Studio Tour
        4: [
            BookingItem(
                name: "Warner Bros. Studio Tour London", kind: .ticket,
                note: "£58.50 (~€68) с человека. Строго по тайм-слоту, билеты уже должны быть куплены заранее.",
                officialURLString: "https://www.wbstudiotour.co.uk/tickets/", officialLabel: "Купить билет",
                mapsQuery: "Warner Bros Studio Tour London"
            ),
        ],

        // День 5 — Котсуолдс · паб Кларксона · Берфорд
        5: [
            BookingItem(
                name: "Аренда автомобиля, 9–10.09", kind: .transport,
                note: "Compact или Mid-size, 2 дня. Забрать утром 9.09 в центре Лондона, вернуть вечером 10.09. Бронируйте заранее — в сезон машин мало.",
                officialURLString: "https://www.rentalcars.com", officialLabel: "Забронировать",
                mapsQuery: "Car hire London city centre"
            ),
            BookingItem(
                name: "The Royal Oak, Берфорд ★★★", kind: .hotel,
                note: "£120–180/ночь · исторический паб-отель на High Street, 1 ночь (09.09)",
                mapsQuery: "The Royal Oak Hotel Burford",
                bookingComQuery: "The Royal Oak Hotel Burford Oxfordshire"
            ),
            BookingItem(
                name: "The Farmer's Dog, Astall", kind: .restaurant,
                note: "Паб Джереми Кларксона — бронь стола обязательна, закрыт вс/пн.",
                mapsQuery: "The Farmer's Dog Asthall"
            ),
        ],

        // День 9 — Париж, прилёт
        9: [
            BookingItem(
                name: "Евростар Лондон → Париж", kind: .transport,
                note: "13.09 — цены растут по мере заполнения поезда.",
                officialURLString: "https://www.eurostar.com/uk-en", officialLabel: "Купить билет",
                mapsQuery: "Gare du Nord Paris"
            ),
            BookingItem(
                name: "La Chambre du Marais ★★★★", kind: .hotel,
                note: "€250–320/ночь · 19 номеров, рядом с Центром Помпиду · 2 ночи",
                mapsQuery: "La Chambre du Marais Paris",
                bookingComQuery: "La Chambre du Marais Paris"
            ),
            BookingItem(
                name: "Hôtel de JoBo ★★★★", kind: .hotel,
                note: "€180–350/ночь · бывший монастырь XVII века, шампань-бар",
                mapsQuery: "Hotel de JoBo Paris",
                bookingComQuery: "Hotel de JoBo Paris"
            ),
        ],

        // День 10 — Лувр · Монмартр
        10: [
            BookingItem(
                name: "Лувр", kind: .ticket,
                note: "€22 (ЕС) / €32 (остальные) по тайм-слоту.",
                officialURLString: "https://ticket.louvre.fr/en", officialLabel: "Купить билет",
                mapsQuery: "Musee du Louvre Paris"
            ),
            BookingItem(
                name: "Bateaux Mouches", kind: .ticket,
                note: "€17–18/чел. С онлайн-билетом — почти без очереди.",
                officialURLString: "https://www.bateaux-mouches.fr/en/reservation/tickets", officialLabel: "Купить билет",
                mapsQuery: "Bateaux Mouches Paris"
            ),
        ],

        // День 11 — Disneyland Park
        11: [
            BookingItem(
                name: "Disneyland Park — билет на 15.09", kind: .ticket,
                note: "Датированный билет — заранее онлайн, дешевле на 30–40%, чем в кассе.",
                officialURLString: "https://tickets.disneylandparis.com/en-gb/tickets", officialLabel: "Купить билет",
                mapsQuery: "Disneyland Park Paris"
            ),
            BookingItem(
                name: "Explorers Hotel Marne-la-Vallée ★★★", kind: .hotel,
                note: "€137–170/ночь · шаттл до парков, оптимален по цене · 2 ночи",
                mapsQuery: "Explorers Hotel Marne-la-Vallee",
                bookingComQuery: "Explorers Hotel Marne-la-Vallee"
            ),
            BookingItem(
                name: "Disney's Newport Bay Club ★★★★", kind: .hotel,
                note: "€230–400+/ночь · 10 мин пешком до Disney Village",
                mapsQuery: "Disney Newport Bay Club",
                bookingComQuery: "Disney Newport Bay Club Paris"
            ),
        ],

        // День 12 — Disney Adventure World
        12: [
            BookingItem(
                name: "Disney Adventure World — билет на 16.09", kind: .ticket,
                note: "Датированный билет на конкретную дату — заранее онлайн.",
                officialURLString: "https://tickets.disneylandparis.com/en-gb/tickets", officialLabel: "Купить билет",
                mapsQuery: "Disney Adventure World Paris"
            ),
        ],

        // День 13 — Брюгге
        13: [
            BookingItem(
                name: "Белфорт (звонница)", kind: .ticket,
                note: "€15/чел за подъём. Внутри не больше 70 человек одновременно.",
                officialURLString: "https://www.museabrugge.be/en/tickets", officialLabel: "Купить билет",
                mapsQuery: "Belfort Bruges"
            ),
            BookingItem(
                name: "Grand Hotel Casselbergh ★★★★", kind: .hotel,
                note: "€150–280/ночь · 150 м от Markt · подземный паркинг ~€30/сутки",
                mapsQuery: "Grand Hotel Casselbergh Bruges",
                bookingComQuery: "Grand Hotel Casselbergh Bruges"
            ),
            BookingItem(
                name: "Hotel Dukes' Palace ★★★★★", kind: .hotel,
                note: "€250–360/ночь · герцогский дворец XV века",
                mapsQuery: "Hotel Dukes Palace Bruges",
                bookingComQuery: "Hotel Dukes Palace Bruges"
            ),
        ],

        // День 14 — Бон
        14: [
            BookingItem(
                name: "Le Central Boutique-Hôtel ★★★", kind: .hotel,
                note: "€90–229/ночь · напротив Hospices de Beaune",
                mapsQuery: "Le Central Boutique Hotel Beaune",
                bookingComQuery: "Le Central Boutique Hotel Beaune"
            ),
            BookingItem(
                name: "Caves Madeleine, Бон", kind: .restaurant,
                note: "Дегустационное меню, общий стол — небольшой зал, бронь обязательна.",
                mapsQuery: "Caves Madeleine Beaune"
            ),
        ],

        // День 15 — Анси
        15: [
            BookingItem(
                name: "Splendid Hotel Lac d'Annecy ★★★★", kind: .hotel,
                note: "€200–320/ночь · ар-деко, канал Vassé",
                mapsQuery: "Splendid Hotel Annecy",
                bookingComQuery: "Splendid Hotel Lac d'Annecy"
            ),
            BookingItem(
                name: "Hôtel Le Pélican ★★★★", kind: .hotel,
                note: "€150–250/ночь · вид на озеро и горы",
                mapsQuery: "Hotel Le Pelican Annecy",
                bookingComQuery: "Hotel Le Pelican Annecy"
            ),
        ],

        // День 16 — Шамони
        16: [
            BookingItem(
                name: "Téléphérique de l'Aiguille du Midi", kind: .ticket,
                note: "€83/чел туда-обратно. Слот бронировать заранее, ранний утренний — приоритет.",
                officialURLString: "https://aiguilledumidi.montblancnaturalresort.com/en/ticketing", officialLabel: "Купить билет",
                mapsQuery: "Aiguille du Midi Chamonix"
            ),
            BookingItem(
                name: "Big Sky Hotel & Spa ★★★★", kind: .hotel,
                note: "€120–280/ночь · район Les Bossons, спа, горные виды · 2 ночи",
                mapsQuery: "Big Sky Hotel Spa Chamonix",
                bookingComQuery: "Big Sky Hotel Spa Chamonix"
            ),
            BookingItem(
                name: "Plan B Hotel — Living Chamonix ★★★", kind: .hotel,
                note: "€100–200/ночь · мини-боулинг, сауна/хаммам",
                mapsQuery: "Plan B Hotel Living Chamonix",
                bookingComQuery: "Plan B Hotel Living Chamonix"
            ),
        ],

        // День 17 — Ледник Мер-де-Глас
        17: [
            BookingItem(
                name: "La Cabane des Praz, Шамони", kind: .restaurant,
                note: "Небольшой зал — вечером без брони не сесть.",
                mapsQuery: "La Cabane des Praz Chamonix"
            ),
        ],

        // День 21 — Перевал · Аоста · термы
        21: [
            BookingItem(
                name: "QC Terme — вечерний вход", kind: .ticket,
                note: "Слот в термы на вечер — бронируйте заранее, вечера загружены.",
                officialURLString: "https://www.qcterme.com/en/pre-saint-didier/qc-terme-pre-saint-didier/prices-opening", officialLabel: "Купить билет",
                mapsQuery: "QC Terme Pre Saint Didier"
            ),
            BookingItem(
                name: "QC Terme Monte Bianco Spa and Resort ★★★★", kind: .hotel,
                note: "€250–390/ночь · термальный комплекс с видом на Монблан · 2 ночи",
                mapsQuery: "QC Terme Monte Bianco Spa and Resort",
                bookingComQuery: "QC Terme Monte Bianco Spa and Resort Pre Saint Didier"
            ),
            BookingItem(
                name: "Residence Villaggio delle Alpi ★★★", kind: .hotel,
                note: "€90–150/ночь · апарт-отель, 5 мин до подъёмников Courmayeur",
                mapsQuery: "Residence Villaggio delle Alpi Courmayeur",
                bookingComQuery: "Residence Villaggio delle Alpi Courmayeur"
            ),
        ],

        // День 22 — Термальный день
        22: [
            BookingItem(
                name: "QC Terme Pré Saint Didier — день", kind: .ticket,
                note: "€46–70/чел в зависимости от пакета. Строго по тайм-слоту, выходной день загружен.",
                officialURLString: "https://www.qcterme.com/en/pre-saint-didier/qc-terme-pre-saint-didier/prices-opening", officialLabel: "Купить билет",
                mapsQuery: "QC Terme Pre Saint Didier"
            ),
            BookingItem(
                name: "Ristorante Baita Ermitage", kind: .restaurant,
                note: "Небольшой зал — бронируйте заранее.",
                mapsQuery: "Ristorante Baita Ermitage Pre Saint Didier"
            ),
        ],
    ]

    static func items(for dayID: Int) -> [BookingItem] {
        items[dayID] ?? []
    }
}
