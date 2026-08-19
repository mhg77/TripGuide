import Foundation

/// Билеты, отели и рестораны с бронью — по номеру дня (TripDay.id).
/// Официальные ссылки указаны только там, где сайт точно известен (крупные операторы).
/// Для отелей и небольших ресторанов — поиск на карте / Booking.com, без выдуманных ссылок.
enum BookingData {
    static let items: [Int: [BookingItem]] = [

        // День 1 — Лондон, прилёт
        1: [
            BookingItem(
                name: "Апартаменты, 5 Stanwick Road", kind: .hotel,
                note: "W14 8TL (Hammersmith & Fulham) · 7 ночей. До центра ~20–30 мин на метро.",
                mapsQuery: "5 Stanwick Road London W14 8TL"
            ),
        ],

        // День 2 — Вестминстер · Arsenal–Chelsea
        2: [
            BookingItem(
                name: "Национальная галерея", kind: .ticket,
                note: "Вход бесплатный. Возьмите бесплатный тайм-слот на открытие (10:00) — меньше очередь.",
                officialURLString: "https://www.nationalgallery.org.uk/visiting", officialLabel: "Забронировать слот",
                mapsQuery: "National Gallery London"
            ),
            BookingItem(
                name: "Arsenal – Chelsea, Emirates", kind: .ticket,
                note: "06.09, начало 16:30 — у стадиона к 15:30. Дерби, билеты берут заранее.",
                officialURLString: "https://www.arsenal.com/tickets", officialLabel: "Билеты",
                mapsQuery: "Emirates Stadium London"
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
                name: "Prince of Burford ★★★", kind: .hotel,
                note: "Исторический дом на High Street в Берфорде, 1 ночь (09.09).",
                mapsQuery: "Prince of Burford",
                bookingComQuery: "Prince of Burford Burford Oxfordshire"
            ),
            BookingItem(
                name: "The Farmer's Dog, Astall", kind: .restaurant,
                note: "Паб Джереми Кларксона — бронь стола обязательна, закрыт вс/пн.",
                mapsQuery: "The Farmer's Dog Asthall"
            ),
        ],

        // День 6 — Британский музей · Сохо · пабы
        6: [
            BookingItem(
                name: "Экскурсия «Вековые пабы Лондона»", kind: .ticket,
                note: "18:00–20:00 · старт у Blue Plaque (Christ's Hospital, EC1A 7BA). Бронь заранее.",
                mapsQuery: "Christ's Hospital Blue Plaque Newgate Street London"
            ),
            BookingItem(
                name: "Blacklock Soho", kind: .restaurant,
                note: "Стейк-хаус, ужин ~16:30. Стол лучше забронировать.",
                mapsQuery: "Blacklock Soho London"
            ),
        ],

        // День 7 — Camden · Little Venice
        7: [
            BookingItem(
                name: "Coretto by the Canal", kind: .restaurant,
                note: "Шампань-бранч у канала, ~11:00. Бронь на бранч желательна.",
                mapsQuery: "Coretto by the Canal London"
            ),
        ],

        // День 8 — парки · London Eye
        8: [
            BookingItem(
                name: "London Eye", kind: .ticket,
                note: "€65–95 за двоих. Закатный слот бронируйте заранее.",
                officialURLString: "https://www.londoneye.com/tickets-and-prices/", officialLabel: "Купить билет",
                mapsQuery: "London Eye"
            ),
            BookingItem(
                name: "The Truth, Хаммерсмит", kind: .restaurant,
                note: "Бранч рядом с отелем, ~11:00.",
                mapsQuery: "The Truth cafe Hammersmith London"
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

        // День 13 — Бон
        13: [
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

        // День 14 — Анси
        14: [
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

        // День 15 — Шамони
        15: [
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

        // День 16 — Ледник Мер-де-Глас
        16: [
            BookingItem(
                name: "La Cabane des Praz, Шамони", kind: .restaurant,
                note: "Небольшой зал — вечером без брони не сесть.",
                mapsQuery: "La Cabane des Praz Chamonix"
            ),
        ],

        // День 20 — Аутлет Серравалле → Турин
        20: [
            BookingItem(
                name: "NH Collection Torino Piazza Carlina ★★★★", kind: .hotel,
                note: "€160–260/ночь · историческое палаццо в центре, 10 мин до Моле · 2 ночи",
                mapsQuery: "NH Collection Torino Piazza Carlina",
                bookingComQuery: "NH Collection Torino Piazza Carlina"
            ),
            BookingItem(
                name: "Turin Palace Hotel ★★★★★", kind: .hotel,
                note: "€220–360/ночь · напротив вокзала Porta Nuova, крытый паркинг рядом",
                mapsQuery: "Turin Palace Hotel",
                bookingComQuery: "Turin Palace Hotel Torino"
            ),
            BookingItem(
                name: "Ristorante Consorzio, Турин", kind: .restaurant,
                note: "Пьемонтская классика, небольшой зал — бронь на ужин обязательна.",
                mapsQuery: "Ristorante Consorzio Torino"
            ),
        ],

        // День 21 — Прогулка по Турину
        21: [
            BookingItem(
                name: "Museo Egizio — билет по слоту", kind: .ticket,
                note: "€18/чел, второе в мире собрание после Каира. Берите онлайн-слот на утро.",
                officialURLString: "https://museoegizio.it/en/", officialLabel: "Купить билет",
                mapsQuery: "Museo Egizio Torino"
            ),
            BookingItem(
                name: "Mole Antonelliana + Museo del Cinema", kind: .ticket,
                note: "Музей кино + панорамный лифт ~€19/чел. Билет на лифт лучше заранее.",
                officialURLString: "https://www.museocinema.it/en", officialLabel: "Купить билет",
                mapsQuery: "Mole Antonelliana Torino"
            ),
            BookingItem(
                name: "Caffè Al Bicerin, Турин", kind: .restaurant,
                note: "Историческое кафе с 1763 года — местный биричин. Тесно, приходите пораньше.",
                mapsQuery: "Caffe Al Bicerin Torino"
            ),
        ],
    ]

    static func items(for dayID: Int) -> [BookingItem] {
        items[dayID] ?? []
    }
}
