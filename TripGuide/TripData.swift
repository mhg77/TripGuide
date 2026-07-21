import Foundation

// Данные путеводителя "Лондон → Лион" v2 — 23 дня, 05–27 сентября 2026.
// Один город/точка на маршруте = один "intro" (показывается на первый день пребывания).

enum TripData {

    static let allDays: [TripDay] = [

        // MARK: - ЛОНДОН (05–13.09, 8 ночей)

        TripDay(
            id: 1, day: 5, weekday: "Сб", city: .london, subtitle: "Прилёт · South Bank",
            intro: """
            Столица начинает маршрут — восемь дней пешком и на метро, без машины. Обязательные точки разбросаны по первой неделе, остальное — свободные прогулки.

            Ночлег · 8 ночей, Covent Garden
            Henrietta Experimental ★★★★ — €175–260/ночь. Дизайнерский, тихий, 2 мин до Savoy Theatre.
            The Z Hotel Covent Garden ★★★ — €100–200/ночь. Компактный, бюджетнее, тоже в центре.
            """,
            blocks: [
                PlanBlock(icon: "sun.max.fill", label: "День", text: "Заселение в отель, лёгкая прогулка без спешки — освоиться после перелёта."),
                PlanBlock(icon: "sunset.fill", label: "Вечер", text: "South Bank вдоль Темзы, London Eye на закате, вид на Биг-Бен с моста."),
                PlanBlock(icon: "ticket.fill", label: "Билет (опция)", text: "London Eye — €65–95 за двоих (стандартный слот). Fast Track с отдельной очередью — доплата ~€45–55 на двоих. Без него очередь на посадку 20–40 минут в разгар дня, с Fast Track — около 5 минут."),
                PlanBlock(icon: "fork.knife", label: "Ужин", text: "Sea Containers Restaurant (вид на реку) или проще — Giraffe."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Covent Garden"),
            ],
            pois: [
                POI(name: "Отель, Covent Garden", category: .hotel, latitude: 51.5117, longitude: -0.1240),
                POI(name: "South Bank", category: .sight, latitude: 51.5063, longitude: -0.1147),
                POI(name: "London Eye", category: .sight, latitude: 51.5033, longitude: -0.1195),
                POI(name: "Биг-Бен (вид с моста)", category: .sight, latitude: 51.5007, longitude: -0.1246),
                POI(name: "Sea Containers Restaurant", category: .food, latitude: 51.5075, longitude: -0.1078),
            ],
            warning: nil,
            fact: "London Eye строили как временную конструкцию к миллениуму 2000 года — колесо должно было простоять всего пять лет, но оказалось настолько популярным, что стало постоянным символом города.",
            todayFocus: "South Bank и London Eye — 10 минут пешком от отеля."
        ),

        TripDay(
            id: 2, day: 6, weekday: "Вс", city: .london, subtitle: "Вестминстер",
            intro: nil,
            blocks: [
                PlanBlock(icon: "sunrise.fill", label: "Утро", text: "Букингемский дворец (смена караула, если по расписанию), Сент-Джеймсский парк."),
                PlanBlock(icon: "fork.knife", label: "Обед", text: "Blue Boar Pub рядом с Вестминстером."),
                PlanBlock(icon: "sun.max.fill", label: "День", text: "Вестминстерское аббатство, Биг-Бен, Трафальгарская площадь, при желании — Национальная галерея."),
                PlanBlock(icon: "ticket.fill", label: "Билет", text: "Вестминстерское аббатство — €65–70 за двоих, вход строго по тайм-слоту. Фаст-трека нет: без брони очередь 45–90 минут в разгар дня, по забронированному слоту — почти без ожидания."),
                PlanBlock(icon: "fork.knife", label: "Ужин", text: "Marquis of Westminster."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Covent Garden"),
            ],
            pois: [
                POI(name: "Отель, Covent Garden", category: .hotel, latitude: 51.5117, longitude: -0.1240),
                POI(name: "Букингемский дворец", category: .sight, latitude: 51.5014, longitude: -0.1419),
                POI(name: "Сент-Джеймсский парк", category: .activity, latitude: 51.5027, longitude: -0.1329),
                POI(name: "Blue Boar Pub", category: .food, latitude: 51.4974, longitude: -0.1349),
                POI(name: "Вестминстерское аббатство", category: .sight, latitude: 51.4994, longitude: -0.1273),
                POI(name: "Биг-Бен", category: .sight, latitude: 51.5007, longitude: -0.1246),
                POI(name: "Трафальгарская площадь", category: .sight, latitude: 51.5080, longitude: -0.1281),
                POI(name: "Национальная галерея", category: .sight, latitude: 51.5089, longitude: -0.1283),
            ],
            warning: nil,
            fact: "«Биг-Бен» — имя большого колокола, а не башни целиком; сама башня официально называется Elizabeth Tower с 2012 года, в честь бриллиантового юбилея Елизаветы II. Колокол весит около 13,7 тонны.",
            todayFocus: "Вестминстер и Букингемский дворец."
        ),

        TripDay(
            id: 3, day: 7, weekday: "Пн", city: .london, subtitle: "Тауэр · Гринвич",
            intro: nil,
            blocks: [
                PlanBlock(icon: "sunrise.fill", label: "Утро", text: "Тауэр Лондона, прогулка по Тауэрскому мосту."),
                PlanBlock(icon: "ticket.fill", label: "Билет", text: "Тауэр Лондона — €65–80 за двоих по тайм-слоту. Фаст-трека нет: без брони очередь на входе/досмотре 30–60 минут в сезон, по забронированному слоту — 10–15 минут."),
                PlanBlock(icon: "fork.knife", label: "Обед", text: "Borough Market — Arabica Borough Market или Boro Bistro."),
                PlanBlock(icon: "sun.max.fill", label: "День", text: "Кораблик по Темзе от Тауэра до Гринвича, Cutty Sark, Королевская обсерватория (нулевой меридиан)."),
                PlanBlock(icon: "ticket.fill", label: "Билеты", text: "Кораблик Тауэр→Гринвич — €28–40 за двоих, фаст-трека нет, но с онлайн-билетом посадка почти сразу (без брони у кассы можно потерять 20–30 минут). Королевская обсерватория (линия Гринвичского меридиана + экспозиция) — €46–52 за двоих по тайм-слоту, очередей практически нет."),
                PlanBlock(icon: "fork.knife", label: "Ужин", text: "Bill's Greenwich или Hawksmoor Wood Wharf."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Covent Garden"),
            ],
            pois: [
                POI(name: "Отель, Covent Garden", category: .hotel, latitude: 51.5117, longitude: -0.1240),
                POI(name: "Тауэр Лондона", category: .sight, latitude: 51.5081, longitude: -0.0759),
                POI(name: "Тауэрский мост", category: .sight, latitude: 51.5055, longitude: -0.0754),
                POI(name: "Borough Market", category: .food, latitude: 51.5055, longitude: -0.0910),
                POI(name: "Cutty Sark", category: .sight, latitude: 51.4826, longitude: -0.0077),
                POI(name: "Королевская обсерватория, Гринвич", category: .sight, latitude: 51.4769, longitude: -0.0005),
            ],
            warning: nil,
            fact: "Гринвичская обсерватория стоит точно на нулевом меридиане — можно встать одной ногой в Западном, а другой в Восточном полушарии. Именно отсюда отсчитывается всемирное время (GMT).",
            todayFocus: "Тауэр, Тауэрский мост, Borough Market и Гринвич по Темзе."
        ),

        TripDay(
            id: 4, day: 8, weekday: "Вт", city: .london, subtitle: "Harry Potter Studio Tour",
            intro: nil,
            blocks: [
                PlanBlock(icon: "sun.max.fill", label: "День", text: "Целиком на Warner Bros. Studio Tour в Уотфорде (шаттл от Watford Junction). Билеты уже должны быть куплены заранее — закладывайте 3–4 часа на сам тур."),
                PlanBlock(icon: "ticket.fill", label: "Билет", text: "£58.50 (~€68) с человека, вход строго по забронированному тайм-слоту. Отдельного фаст-трека нет и не нужен — с билетом на входе ждать около 15 минут в любом случае."),
                PlanBlock(icon: "fork.knife", label: "Обед", text: "Кафе на территории студии (Backlot Café)."),
                PlanBlock(icon: "sunset.fill", label: "Вечер", text: "Возврат в центр, свободный вечер — можно просто отдохнуть у отеля."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Covent Garden"),
            ],
            pois: [
                // Порядок повторяет день: поезд до Watford Junction, оттуда шаттл к студии.
                POI(name: "Отель, Covent Garden", category: .hotel, latitude: 51.5117, longitude: -0.1240),
                POI(name: "Watford Junction", category: .transfer, latitude: 51.6634, longitude: -0.3958),
                POI(name: "Warner Bros. Studio Tour", category: .activity, latitude: 51.6925, longitude: -0.4165),
            ],
            warning: nil,
            fact: "Диагон-аллею для фильмов о Гарри Поттере строили как настоящую улицу в натуральную величину и до сих пор используют декорацию без изменений — фасады снимали с реальных исторических зданий Лондона.",
            todayFocus: "Студия Warner Bros в Уотфорде, ~30 км к северо-западу.",
            easterEggText: "Пасхалка: пройдите весь тур, представляя, что письмо из Хогвартса просто задержалось в пути лет на двадцать. И обязательно закажите Butterbeer в кафе Backlot — рецепт держат в секрете, но на вкус подозрительно похоже на сливочную пенку с ирисками."
        ),

        TripDay(
            id: 5, day: 9, weekday: "Ср", city: .london, subtitle: "Котсуолдс · паб Кларксона",
            intro: nil,
            blocks: [
                PlanBlock(icon: "sun.max.fill", label: "День", text: "Поездка в Оксфордшир (~1,5 ч в одну сторону) — обязательно бронируйте столик заранее, паб закрыт по вс/пн. По пути стоит заглянуть в один из городков Котсуолдса (Burford или Bourton-on-the-Water)."),
                PlanBlock(icon: "fork.knife", label: "Обед", text: "The Farmer's Dog — паб Джереми Кларксона в Astall. Стейк-пай и раклет-крамбл — фирменные блюда."),
                PlanBlock(icon: "sunset.fill", label: "Вечер", text: "Возврат в Лондон."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Covent Garden"),
                PlanBlock(icon: "map.fill", label: "Маршрут", text: "Лондон → Котсуолдс (117 км / ~1 ч 45 мин), единственный день без машины, требующий отдельного трансфера."),
            ],
            pois: [
                // Отель — стартовая точка дня: от него на карте строится маршрут до паба.
                POI(name: "Отель, Covent Garden", category: .hotel, latitude: 51.5117, longitude: -0.1240),
                POI(name: "Burford", category: .sight, latitude: 51.8110, longitude: -1.6360),
                POI(name: "The Farmer's Dog, Astall", category: .food, latitude: 51.8020, longitude: -1.6230),
                POI(name: "Bourton-on-the-Water", category: .sight, latitude: 51.8767, longitude: -1.7530),
            ],
            warning: nil,
            fact: "Котсуолдс застроен характерным медово-жёлтым известняком, который называют «котсуолдским камнем» — при закате он приобретает золотистый оттенок, из-за чего регион иногда называют «краем мёда и масла».",
            todayFocus: nil,
            easterEggText: "Пасхалка: если официант спросит, как прожарить стейк, отвечайте в стиле Top Gear — «быстро и с драмой». Кларксон гонял по этим же дорогам Котсуолдса не в одном спецвыпуске шоу — а вы делаете это прямо сейчас, только на пикапе и без съёмочной группы."
        ),

        TripDay(
            id: 6, day: 10, weekday: "Чт", city: .london, subtitle: "Британский музей · Сохо",
            intro: nil,
            blocks: [
                PlanBlock(icon: "sunrise.fill", label: "Утро", text: "Британский музей (вход бесплатный, закладывайте 2–3 часа)."),
                PlanBlock(icon: "fork.knife", label: "Обед", text: "Covent Garden, любое кафе рядом с отелем."),
                PlanBlock(icon: "sun.max.fill", label: "День", text: "Прогулка по Сохо, флагман Stone Island на 79 Brewer St."),
                PlanBlock(icon: "fork.knife", label: "Ужин", text: "Blacklock Soho (стейк-хаус) или Scarlett Green."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Covent Garden"),
            ],
            pois: [
                POI(name: "Отель, Covent Garden", category: .hotel, latitude: 51.5117, longitude: -0.1240),
                POI(name: "Британский музей", category: .sight, latitude: 51.5194, longitude: -0.1270),
                POI(name: "Сохо", category: .sight, latitude: 51.5136, longitude: -0.1367),
                POI(name: "Stone Island, 79 Brewer St", category: .activity, latitude: 51.5129, longitude: -0.1365),
                POI(name: "Blacklock Soho", category: .food, latitude: 51.5128, longitude: -0.1329),
            ],
            warning: nil,
            fact: "Британский музей был первым в мире национальным публичным музеем (открыт в 1753 году) и с самого начала задумывался как бесплатный для всех посетителей — этот принцип соблюдается до сих пор.",
            todayFocus: "Британский музей и Сохо — оба в 10–15 минутах пешком от отеля."
        ),

        TripDay(
            id: 7, day: 11, weekday: "Пт", city: .london, subtitle: "Camden Market",
            intro: nil,
            blocks: [
                PlanBlock(icon: "sunrise.fill", label: "Утро", text: "Camden Market — рынок с едой и винтажными лавками."),
                PlanBlock(icon: "fork.knife", label: "Обед", text: "Magic Falafel или Bun Boy Korean Street Food прямо на рынке."),
                PlanBlock(icon: "sun.max.fill", label: "День", text: "Прогулка вдоль Regent's Canal в сторону Little Venice."),
                PlanBlock(icon: "fork.knife", label: "Ужин", text: "Свободный выбор в центре — можно вернуться в Ковент-Гарден."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Covent Garden"),
            ],
            pois: [
                POI(name: "Отель, Covent Garden", category: .hotel, latitude: 51.5117, longitude: -0.1240),
                POI(name: "Camden Market", category: .activity, latitude: 51.5416, longitude: -0.1462),
                POI(name: "Regent's Canal", category: .sight, latitude: 51.5290, longitude: -0.1730),
                POI(name: "Little Venice", category: .sight, latitude: 51.5210, longitude: -0.1830),
            ],
            warning: nil,
            fact: "Camden Market вырос из одной небольшой ремесленной ярмарки 1974 года на месте бывших конюшен и сегодня принимает около 250 000 посетителей в неделю — это один из самых посещаемых рынков мира.",
            todayFocus: "Camden Market, дальше пешком вдоль канала на запад."
        ),

        TripDay(
            id: 8, day: 12, weekday: "Сб", city: .london, subtitle: "Portobello Road",
            intro: nil,
            blocks: [
                PlanBlock(icon: "sunrise.fill", label: "Утро", text: "Portobello Road Market — суббота лучший день для рынка (антиквариат, винтаж, стрит-фуд)."),
                PlanBlock(icon: "fork.knife", label: "Обед", text: "Dishoom Permit Room Portobello или Eggslut Portobello."),
                PlanBlock(icon: "sun.max.fill", label: "День", text: "Кенсингтон-гарденс, Гайд-парк; вечером — сборы к отъезду."),
                PlanBlock(icon: "fork.knife", label: "Ужин", text: "Прощальный ужин рядом с отелем в Ковент-Гардене."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Covent Garden"),
            ],
            pois: [
                POI(name: "Отель, Covent Garden", category: .hotel, latitude: 51.5117, longitude: -0.1240),
                POI(name: "Portobello Road Market", category: .activity, latitude: 51.5158, longitude: -0.2049),
                POI(name: "Кенсингтон-гарденс", category: .activity, latitude: 51.5073, longitude: -0.1857),
                POI(name: "Гайд-парк", category: .activity, latitude: 51.5073, longitude: -0.1657),
            ],
            warning: nil,
            fact: "Portobello Road — самый длинный антикварный рынок под открытым небом в мире, растянувшийся почти на 1,6 км; название улице дала не итальянская гавань, а ферма XVIII века, названная в честь взятия панамского порта Portobelo в 1739 году.",
            todayFocus: "Portobello Road и Гайд-парк на западе города."
        ),

        // MARK: - ПАРИЖ (13–17.09, 4 ночи)

        TripDay(
            id: 9, day: 13, weekday: "Вс", city: .paris, subtitle: "Прилёт · Марэ",
            intro: """
            Четыре ночи: вечер прилёта и полный день на сам Париж, затем два дня в Диснейленде — отдельно классический парк и отдельно Disney Adventure World. Машина (Dodge Ram) не нужна до самого выезда из региона.

            Ночлег · 13–15.09 (2 ночи), Марэ
            La Chambre du Marais ★★★★ — €250–320/ночь. 19 номеров, рядом с Центром Помпиду.
            Hôtel de JoBo ★★★★ — €180–350/ночь. Бывший монастырь XVII века, шампань-бар.

            Ночлег · 15–17.09 (2 ночи), у парков Диснейленда
            Explorers Hotel Marne-la-Vallée ★★★ — €137–170/ночь. Семейный, шаттл до парков — оптимален по цене.
            Disney's Newport Bay Club ★★★★ — €230–400+/ночь. 10 мин пешком до Disney Village, динамические цены.
            """,
            blocks: [
                PlanBlock(icon: "car.fill", label: "Переезд", text: "Евростар Лондон → Париж, ~2 ч 15 мин"),
                PlanBlock(icon: "sun.max.fill", label: "День", text: "Заселение в отель в Марэ, лёгкая прогулка по кварталу."),
                PlanBlock(icon: "sunset.fill", label: "Вечер", text: "Эйфелева башня на закате (метро до Trocadéro — лучший вид), прогулка по набережным Сены."),
                PlanBlock(icon: "fork.knife", label: "Ужин", text: "Au Bourguignon du Marais (бургундская кухня) или Bistrot des Vosges."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Марэ, Париж"),
            ],
            pois: [
                // Порядок повторяет вечер: метро до Трокадеро (лучший вид), пешком к башне.
                POI(name: "Отель, Марэ", category: .hotel, latitude: 48.8575, longitude: 2.3600),
                POI(name: "Трокадеро", category: .sight, latitude: 48.8626, longitude: 2.2870),
                POI(name: "Эйфелева башня", category: .sight, latitude: 48.8584, longitude: 2.2945),
                POI(name: "Набережные Сены", category: .sight, latitude: 48.8580, longitude: 2.3350),
            ],
            warning: nil,
            fact: "Эйфелеву башню строили как временный экспонат Всемирной выставки 1889 года и планировали снести через 20 лет — спасли её антенны: башню оставили ради радиосвязи.",
            todayFocus: "Эйфелева башня и Трокадеро.",
            easterEggText: "Пасхалка: по официальной кинематографической версии («Гадкий я»), Эйфелеву башню как минимум раз похищали миньоны, заменив надувной копией. Сегодняшняя точно останется на месте — но взгляд на закате всё равно бросьте, на всякий случай."
        ),

        TripDay(
            id: 10, day: 14, weekday: "Пн", city: .paris, subtitle: "Лувр · Монмартр",
            intro: nil,
            blocks: [
                PlanBlock(icon: "sunrise.fill", label: "Утро", text: "Лувр (бронируйте слот заранее; хотя бы Джоконда, Ника и галерея Аполлона — 2–3 часа), затем сад Тюильри и площадь Согласия."),
                PlanBlock(icon: "fork.knife", label: "Обед", text: "Кафе у Пале-Рояль или на улице Монторгей."),
                PlanBlock(icon: "sun.max.fill", label: "День", text: "Монмартр: базилика Сакре-Кёр, площадь Тертр с художниками, виноградник. Спуститься через Пигаль к Опере Гарнье."),
                PlanBlock(icon: "sunset.fill", label: "Вечер", text: "Круиз по Сене на закате (Bateaux Mouches, ~1 час) — весь Париж с воды."),
                PlanBlock(icon: "fork.knife", label: "Ужин", text: "Chez Janou (прованская кухня, легендарный шоколадный мусс) или Le Colimaçon в Марэ."),
                PlanBlock(icon: "ticket.fill", label: "Билеты", text: "Лувр — €22 (граждане ЕС) / €32 (остальные) по тайм-слоту; отдельного фаст-трека сверх слота нет, но без брони очередь 1–3 часа. Bateaux Mouches — €17–18/чел, с онлайн-билетом — почти без очереди на посадку."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Марэ, Париж"),
            ],
            pois: [
                POI(name: "Отель, Марэ", category: .hotel, latitude: 48.8575, longitude: 2.3600),
                POI(name: "Лувр", category: .sight, latitude: 48.8606, longitude: 2.3376),
                POI(name: "Сад Тюильри", category: .sight, latitude: 48.8634, longitude: 2.3275),
                POI(name: "Площадь Согласия", category: .sight, latitude: 48.8656, longitude: 2.3212),
                POI(name: "Монмартр · Сакре-Кёр", category: .sight, latitude: 48.8867, longitude: 2.3431),
                POI(name: "Площадь Тертр", category: .sight, latitude: 48.8867, longitude: 2.3406),
                POI(name: "Опера Гарнье", category: .sight, latitude: 48.8719, longitude: 2.3316),
                POI(name: "Bateaux Mouches", category: .activity, latitude: 48.8639, longitude: 2.3007),
            ],
            warning: nil,
            fact: "Стеклянная пирамида Лувра, которую в 1989 году многие критиковали как чужеродную для исторического дворца, спроектирована архитектором Бэй Юймином и состоит из 673 стеклянных панелей — распространённый миф о «666 панелях» неверен.",
            todayFocus: "Лувр, Тюильри, Монмартр и Опера Гарнье.",
            easterEggText: "Пасхалка: у большой пирамиды поищите маленькую перевёрнутую — La Pyramide Inversée во дворе Carrousel. Именно там Дэн Браун поставил финальную сцену «Кода да Винчи» — можно проверить, совпадает ли с фильмом хотя бы освещение."
        ),

        TripDay(
            id: 11, day: 15, weekday: "Вт", city: .disneyland, subtitle: "Disneyland Park",
            intro: nil,
            blocks: [
                PlanBlock(icon: "car.fill", label: "Переезд", text: "Переезд в отель у парков (RER A, ~40 мин)"),
                PlanBlock(icon: "sun.max.fill", label: "День", text: "Весь день в классическом Disneyland Park — Sleeping Beauty Castle, Big Thunder Mountain, парад. Билеты на конкретную дату — заранее онлайн."),
                PlanBlock(icon: "ticket.fill", label: "Premier Access", text: "Опционально: фаст-трек на 1 аттракцион €5–19, безлимитный Ultimate на топ-аттракционы €90–190/день. Без него в разгар дня очередь 30–90 мин (на новинки — до 120 мин)."),
                PlanBlock(icon: "fork.knife", label: "Обед/Ужин", text: "Rainforest Cafe в Disney Village — можно поесть прямо на территории между аттракционами."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Отель у парков"),
            ],
            pois: [
                // Порядок повторяет день: утром переезд из Марэ (RER A), затем парк.
                POI(name: "Отель, Марэ", category: .hotel, latitude: 48.8575, longitude: 2.3600),
                POI(name: "Отель у парков", category: .hotel, latitude: 48.8670, longitude: 2.7810),
                POI(name: "Disneyland Park", category: .activity, latitude: 48.8722, longitude: 2.7758),
                POI(name: "Disney Village", category: .activity, latitude: 48.8703, longitude: 2.7766),
            ],
            warning: nil,
            fact: "Замок Спящей красавицы в Диснейленде Париж — единственный из «дисней-замков» в мире, построенный по мотивам версии сказки Шарля Перро, а не братьев Гримм, и внутри него расположен дракон в подземелье — аниматронная фигура длиной 27 метров.",
            todayFocus: "Disneyland Park, восточная окраина региона.",
            easterEggText: "Пасхалка: по неофициальной легенде парка, если незаметно постучать по одному из камней моста перед замком — обязательно вернёшься в Диснейленд ещё раз. Работает не хуже подковы, а проверить всё равно приятно."
        ),

        TripDay(
            id: 12, day: 16, weekday: "Ср", city: .disneyland, subtitle: "Disney Adventure World",
            intro: nil,
            blocks: [
                PlanBlock(icon: "sun.max.fill", label: "День", text: "Второй парк — Disney Adventure World (бывший Walt Disney Studios): World of Frozen, Marvel Avengers Campus, Worlds of Pixar. Идите пораньше к открытию — очереди на Frozen Ever After растут быстро."),
                PlanBlock(icon: "ticket.fill", label: "Premier Access", text: "Как и вчера — по желанию, €5–19 за аттракцион. На новый мир Frozen очереди по утрам особенно длинные, фаст-трек тут наиболее оправдан."),
                PlanBlock(icon: "fork.knife", label: "Обед/Ужин", text: "Фудкорты внутри парка, или ужин в Disney Village по возвращении."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Отель у парков"),
            ],
            pois: [
                POI(name: "Отель у парков", category: .hotel, latitude: 48.8670, longitude: 2.7810),
                POI(name: "Disney Adventure World", category: .activity, latitude: 48.8659, longitude: 2.7797),
            ],
            warning: nil,
            fact: "Парк открылся в 2002 году как Walt Disney Studios Park и в 2025 году был полностью переосмыслен и переименован в Disney Adventure World — крупнейшее расширение в истории европейского «Диснея», добавившее целый новый мир Frozen.",
            todayFocus: "Disney Adventure World, рядом с первым парком."
        ),

        // MARK: - БРЮГГЕ (17–18.09, 1 ночь)

        TripDay(
            id: 13, day: 17, weekday: "Чт", city: .bruges, subtitle: "Диснейленд → Брюгге",
            intro: """
            «Северная Венеция» — каналы, готические фасады и бельгийский шоколад на полпути между Диснейлендом и Бургундией. Заезд короткий, но исторический центр компактный: всё главное — в 15 минутах пешком друг от друга.

            Самый длинный переезд поездки — читайте перед выездом
            Забираете Dodge Ram у Диснейленда и едете на север в объезд Парижа — 307 км / 3 ч 30 мин без остановок. На следующий день предстоит 614 км / 6 ч 20 мин до Бона. За двое суток вы проедете почти столько же, сколько за всю остальную поездку по горам. Если хочется снизить нагрузку — можно доехать на поезде (Eurostar/Thalys Лондон или Париж → Брюгге, ~2 ч) налегке и вернуться за машиной отдельно, но в этом плане предполагается, что едете на своей.

            Ночлег · 1 ночь, у Markt
            Grand Hotel Casselbergh ★★★★ — €150–280/ночь. 150 м от Markt, подземный паркинг ~€30/сутки — уточните высоту въезда для пикапа.
            Hotel Dukes' Palace ★★★★★ — €250–360/ночь. Герцогский дворец XV века, паркинг ~€38/сутки, тоже проверить клиренс.
            """,
            blocks: [
                PlanBlock(icon: "car.fill", label: "Переезд", text: "Диснейленд → Брюгге: ~307 км / 3 ч 30 мин"),
                PlanBlock(icon: "sun.max.fill", label: "День", text: "Выезд из региона Диснейленда на север, в объезд Парижа по A1/E15/E17. Границу Франция–Бельгия проезжаете без контроля (Шенген)."),
                PlanBlock(icon: "sunset.fill", label: "Вечер", text: "Заселение, вечерняя прогулка: Markt и Белфорт (звонница XIII века, вид с 83 метров при желании подняться — 366 ступеней), Burg с ратушей, набережная Rozenhoedkaai — самый снимаемый вид Брюгге."),
                PlanBlock(icon: "ticket.fill", label: "Белфорт (опция)", text: "€15/чел за подъём. Официального фаст-трека нет — внутри одновременно не больше 70 человек, поэтому даже с билетом в разгар дня очередь 30–60 минут; рано утром или ближе к закрытию заметно короче."),
                PlanBlock(icon: "fork.knife", label: "Ужин", text: "De Halve Maan — пивоварня в центре города с собственным рестораном, или Bistro Bruut."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Брюгге, у Markt"),
            ],
            pois: [
                // Порядок повторяет день: выезд от отеля у Диснейленда, вечер в Брюгге.
                POI(name: "Отель у парков", category: .hotel, latitude: 48.8670, longitude: 2.7810),
                POI(name: "Отель, Брюгге", category: .hotel, latitude: 51.2077, longitude: 3.2280),
                POI(name: "Markt", category: .sight, latitude: 51.2085, longitude: 3.2247),
                POI(name: "Белфорт", category: .sight, latitude: 51.2083, longitude: 3.2247),
                POI(name: "Burg", category: .sight, latitude: 51.2091, longitude: 3.2266),
                POI(name: "Rozenhoedkaai", category: .sight, latitude: 51.2075, longitude: 3.2265),
                POI(name: "De Halve Maan", category: .food, latitude: 51.2038, longitude: 3.2237),
            ],
            warning: nil,
            fact: "В Брюгге зарегистрировано более 50 сортов бельгийского пива, произведённых в самом городе или рядом с ним, а местная пивоварня De Halve Maan качает готовое пиво по подземному трубопроводу длиной 3,2 км прямо к разливочному заводу за городом — трубу проложили в 2016 году, чтобы убрать грузовики с узких улиц.",
            todayFocus: "Burg и Rozenhoedkaai — оба в 5 минутах от Markt.",
            easterEggText: "Пасхалка: весь город, по которому вы гуляете, — почти декорация к чёрной комедии «Залечь на дно в Брюгге» (2008) с Колином Фарреллом. Белфорт, Markt и каналы сняты там практически документально — узнаете кадры на каждом шагу."
        ),

        // MARK: - БУРГУНДИЯ · БОН (18–19.09, 1 ночь)

        TripDay(
            id: 14, day: 18, weekday: "Пт", city: .beaune, subtitle: "Брюгге → Бон",
            intro: """
            Средневековый центр и родина бургундского вина — после длинного переезда из Брюгге короткий вечер среди виноградников придётся кстати.

            Ночлег · 1 ночь, исторический центр
            Le Central Boutique-Hôtel ★★★ — €90–229/ночь. Напротив Hospices de Beaune, здание бывшей почтовой станции.

            Парковка в Боне
            Старый город не рассчитан на 6-метровый пикап. Зона для крупных автомобилей — Avenue de la Liberté (бесплатно первые 4 часа), либо один из муниципальных паркингов чуть дальше от центра. До отеля и Hospices оттуда 10 минут пешком.
            """,
            blocks: [
                PlanBlock(icon: "car.fill", label: "Переезд", text: "Брюгге → Бон: ~614 км / 6 ч 20 мин, рекомендуется остановка в Реймсе"),
                PlanBlock(icon: "sunrise.fill", label: "Утро", text: "Пока туристические автобусы ещё не приехали — короткая прогулка по каналам: Beguinage (бегинаж, объект ЮНЕСКО) и озеро Minnewater («озеро любви»), шоколад на дорогу в любой из лавок на Markt (The Chocolate Line или Dumon). Выезд не позже 9:00."),
                PlanBlock(icon: "sun.max.fill", label: "День", text: "Долгая дорога на юг — трасса A26 идёт вдоль Реймса, стоит сделать там паузу на час-полтора: собор Notre-Dame de Reims, место коронации французских королей, в 5 минутах от съезда с трассы. Дальше — через Труа и Лангр до Бона; заправьтесь GPL заранее, на этом участке станций немного."),
                PlanBlock(icon: "sunset.fill", label: "Вечер", text: "Прибытие в Бон, неспешная прогулка по средневековому центру — крепостные стены, базилика Нотр-Дам с готическими гобеленами."),
                PlanBlock(icon: "fork.knife", label: "Ужин", text: "Caves Madeleine (дегустационное меню, общий стол) или Restaurant Au Coq Bleu."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Le Central Boutique-Hôtel, Бон"),
            ],
            pois: [
                // Порядок повторяет день: утро в Брюгге от отеля, Реймс по пути, вечер в Боне.
                POI(name: "Отель, Брюгге", category: .hotel, latitude: 51.2077, longitude: 3.2280),
                POI(name: "Beguinage, Брюгге", category: .sight, latitude: 51.1998, longitude: 3.2249),
                POI(name: "Minnewater", category: .sight, latitude: 51.1978, longitude: 3.2247),
                POI(name: "Собор Notre-Dame de Reims", category: .sight, latitude: 49.2533, longitude: 4.0347),
                POI(name: "Отель, Бон", category: .hotel, latitude: 47.0238, longitude: 4.8385),
                POI(name: "Старый город, Бон", category: .sight, latitude: 47.0235, longitude: 4.8358),
                POI(name: "Hospices de Beaune", category: .sight, latitude: 47.0242, longitude: 4.8395),
            ],
            warning: "Это самый длинный день за рулём во всей поездке — почти 7 часов чистой езды. Меняйтесь за рулём каждые 2 часа, планируйте минимум одну полноценную остановку помимо Реймса.",
            fact: "Разноцветная черепичная крыша Hospices de Beaune, ставшая символом Бургундии, была уложена в XV веке фламандскими мастерами — тот же геометрический стиль узоров, что и на крышах в Дижоне, пришёл именно из Фландрии, то есть из тех же мест, что вы проезжали накануне в Брюгге.",
            todayFocus: nil
        ),

        // MARK: - АНСИ (19–20.09, 1 ночь)

        TripDay(
            id: 15, day: 19, weekday: "Сб", city: .annecy, subtitle: "Бон → Анси",
            intro: """
            «Венеция Альп» — каналы старого города и одно из самых чистых озёр Европы. Заезд короткий, но самое главное — набережная и Мост Влюблённых — успеете вечером и утром.

            Ночлег · 1 ночь
            Splendid Hotel Lac d'Annecy ★★★★ — €200–320/ночь. Ар-деко, канал Vassé; парковка — общественный гараж у Bonlieu/Hôtel de Ville, лучше для крупной машины.
            Hôtel Le Pélican ★★★★ — €150–250/ночь. Вид на озеро и горы; собственный гараж тесноват для пикапа — тот же общественный паркинг рядом.
            """,
            blocks: [
                PlanBlock(icon: "car.fill", label: "Переезд", text: "Бон → Анси: ~233 км / 2 ч 45 мин"),
                PlanBlock(icon: "sunrise.fill", label: "Утро", text: "Дегустация бургундских вин в винном погребе (Marché aux Vins или домен вокруг Бона), затем выезд."),
                PlanBlock(icon: "fork.knife", label: "Обед", text: "Restaurant Chez Monique (тартифлет, фондю)."),
                PlanBlock(icon: "sunset.fill", label: "Вечер", text: "Прогулка по каналам старого города, Jardins de l'Europe и Мост Влюблённых."),
                PlanBlock(icon: "fork.knife", label: "Ужин", text: "Chez Ingalls (терраса во дворе) или LE FRETI (савойская кухня)."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Splendid Hotel, Анси"),
            ],
            pois: [
                // Порядок повторяет день: утро в Боне от отеля, затем переезд и вечер в Анси.
                POI(name: "Отель, Бон", category: .hotel, latitude: 47.0238, longitude: 4.8385),
                POI(name: "Marché aux Vins, Бон", category: .activity, latitude: 47.0245, longitude: 4.8390),
                POI(name: "Отель, Анси", category: .hotel, latitude: 45.8997, longitude: 6.1264),
                POI(name: "Старый город и каналы, Анси", category: .sight, latitude: 45.8992, longitude: 6.1294),
                POI(name: "Jardins de l'Europe", category: .sight, latitude: 45.9007, longitude: 6.1275),
                POI(name: "Мост Влюблённых", category: .sight, latitude: 45.9022, longitude: 6.1466),
            ],
            warning: nil,
            fact: "Озеро Анси считается одним из самых чистых больших озёр Европы — прозрачность воды достигает 15 метров, и с 1960-х годов вокруг него действует один из первых во Франции межмуниципальных договоров по защите от загрязнения.",
            todayFocus: nil,
            easterEggText: "Пасхалка: Анси — не только «Венеция Альп», но и мировая столица мультипликации: каждый июнь здесь проходит крупнейший в мире фестиваль анимационного кино. Если вечером у озера картинка вокруг покажется слишком красивой для реальности — вам не кажется, тут это профессиональная деформация города."
        ),

        // MARK: - ШАМОНИ (20–22.09, 2 ночи)

        TripDay(
            id: 16, day: 20, weekday: "Вс", city: .chamonix, subtitle: "Aiguille du Midi",
            intro: """
            Столица альпинизма у подножия Монблана, высшей точки Западной Европы.

            Ночлег · 2 ночи
            Big Sky Hotel & Spa ★★★★ — €120–280/ночь. Район Les Bossons, спа, горные виды.
            Plan B Hotel — Living Chamonix ★★★ — €100–200/ночь. Мини-боулинг, сауна/хаммам, живой бар-ресторан.
            """,
            blocks: [
                PlanBlock(icon: "car.fill", label: "Переезд", text: "Анси → Шамони: ~99 км / 1 ч 20 мин"),
                PlanBlock(icon: "sunrise.fill", label: "Утро", text: "Выезд из Анси, дорога вдоль гор."),
                PlanBlock(icon: "sun.max.fill", label: "День", text: "Заселение, затем канатная дорога Téléphérique de l'Aiguille du Midi (билеты бронировать заранее!) — подъём на 3842 м с видом на Монблан."),
                PlanBlock(icon: "ticket.fill", label: "Билет", text: "€83/чел туда-обратно (€61 в одну сторону). Отдельного платного фаст-трека нет — сам билет уже привязан к тайм-слоту; ранний утренний слот и есть приоритет. Без брони в разгар дня очередь 30–90 минут."),
                PlanBlock(icon: "fork.knife", label: "Обед", text: "Наверху, на террасе Aiguille du Midi, или после спуска в городе."),
                PlanBlock(icon: "fork.knife", label: "Ужин", text: "Restaurant Le Fer à Cheval (фондю, вид на горы)."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Big Sky Hotel & Spa, Шамони"),
            ],
            pois: [
                // Порядок повторяет день: выезд из Анси, заселение, затем канатка.
                POI(name: "Отель, Анси", category: .hotel, latitude: 45.8997, longitude: 6.1264),
                POI(name: "Отель, Шамони (Les Bossons)", category: .hotel, latitude: 45.8995, longitude: 6.8420),
                POI(name: "Шамони, центр", category: .sight, latitude: 45.9237, longitude: 6.8694),
                POI(name: "Téléphérique de l'Aiguille du Midi", category: .activity, latitude: 45.9247, longitude: 6.8695),
                POI(name: "Aiguille du Midi, вершина", category: .sight, latitude: 45.8792, longitude: 6.8873),
            ],
            warning: nil,
            fact: "Шамони принимал самые первые в истории зимние Олимпийские игры в 1924 году — тогда соревнования называли просто «Международная спортивная неделя», а официальный статус Олимпиады играм присвоили только задним числом, в 1926-м.",
            todayFocus: nil
        ),

        TripDay(
            id: 17, day: 21, weekday: "Пн", city: .chamonix, subtitle: "Ледник Мер-де-Глас",
            intro: nil,
            blocks: [
                PlanBlock(icon: "sunrise.fill", label: "Утро", text: "Смотровая площадка Le Pas dans le Vide («Шаг в пустоту») на вершине Aiguille du Midi — если ещё не успели накануне."),
                PlanBlock(icon: "sun.max.fill", label: "День", text: "При хорошей погоде — поезд Mer de Glace к леднику, либо прогулка по городу и вдоль реки Арв."),
                PlanBlock(icon: "fork.knife", label: "Обед", text: "La Fine Bouche — уютное семейное заведение с террасой."),
                PlanBlock(icon: "fork.knife", label: "Ужин", text: "La Cabane des Praz — вид на горы, изысканная подача."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Big Sky Hotel & Spa, Шамони"),
            ],
            pois: [
                POI(name: "Отель, Шамони (Les Bossons)", category: .hotel, latitude: 45.8995, longitude: 6.8420),
                POI(name: "Le Pas dans le Vide", category: .sight, latitude: 45.8792, longitude: 6.8873),
                POI(name: "Mer de Glace / Montenvers", category: .sight, latitude: 45.9282, longitude: 6.8747),
                POI(name: "La Cabane des Praz", category: .food, latitude: 45.9350, longitude: 6.8935),
            ],
            warning: nil,
            fact: "Ледник Мер-де-Глас — самый длинный во Франции (около 7 км), но с 1990-х годов он стремительно тает: смотровую лестницу к леднику ежегодно приходится удлинять на несколько десятков ступеней, чтобы дойти до отступившего льда.",
            todayFocus: "Шамони в долине Мон-Блана — свободный день без переезда.",
            easterEggText: "Пасхалка: стеклянная платформа Le Pas dans le Vide висит прямо над обрывом высотой километр — с 2013 года по ней прошли уже миллионы ног, и ни разу она не подвела. Отличный повод для фото, которое родственники потом будут пересылать друг другу с подписью «а нормально было?»."
        ),

        // MARK: - ЛЕ-ЗАРК 1950 (22–25.09, 3 ночи)

        TripDay(
            id: 18, day: 22, weekday: "Вт", city: .lesArcs, subtitle: "Заселение",
            intro: """
            Главная точка отдыха в горах — пешеходная деревня в стиле савойского шале на высоте 1950 м. Отсюда же — однодневная радиалка в аутлет Серравалле.

            Жильё уже забронировано
            Апартаменты в пешеходной деревне Arc 1950, Le Village — собственное жильё, в бюджет поездки не включено.
            """,
            blocks: [
                PlanBlock(icon: "car.fill", label: "Переезд", text: "Шамони → Ле-Зарк: ~120 км / 2 ч, через Bourg-Saint-Maurice"),
                PlanBlock(icon: "fork.knife", label: "Обед", text: "По пути в Bourg-Saint-Maurice — Le Refuge (фондю, раклет) или Mamie Crêpes."),
                PlanBlock(icon: "sun.max.fill", label: "День", text: "Заселение в Ле-Зарк 1950, первое знакомство с деревней — пешеходные улочки в стиле савойского шале."),
                PlanBlock(icon: "fork.knife", label: "Ужин", text: "Le Chalet de Luigi — терраса с видом на горы."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Arc 1950, Le Village"),
            ],
            pois: [
                // Порядок повторяет день: выезд из отеля Шамони, обед в Bourg-Saint-Maurice.
                POI(name: "Отель, Шамони (Les Bossons)", category: .hotel, latitude: 45.8995, longitude: 6.8420),
                POI(name: "Bourg-Saint-Maurice", category: .transfer, latitude: 45.6178, longitude: 6.7710),
                POI(name: "Arc 1950, Le Village", category: .hotel, latitude: 45.5720, longitude: 6.7930),
            ],
            warning: nil,
            fact: "Ле-Зарк 1950 спроектирован архитектором Шарлем Бонифасом сознательно «под старину» — деревня целиком построена в 2003 году, но на вид имитирует савойское шале XVIII века: настоящих трёхсотлетних построек тут нет ни одной.",
            todayFocus: nil
        ),

        TripDay(
            id: 19, day: 23, weekday: "Ср", city: .lesArcs, subtitle: "Горный день",
            intro: nil,
            blocks: [
                PlanBlock(icon: "figure.hiking", label: "День", text: "Пешие маршруты или горные велосипеды с панорамой на массив Монблана; подъёмники в сентябре работают в ограниченном режиме — уточните на месте расписание."),
                PlanBlock(icon: "fork.knife", label: "Обед", text: "La Folie Douce Les Arcs — живая музыка и вид на склоны."),
                PlanBlock(icon: "fork.knife", label: "Ужин", text: "Le Perce Neige — фондю с белыми грибами."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Arc 1950, Le Village"),
            ],
            pois: [
                POI(name: "Arc 1950, Le Village", category: .hotel, latitude: 45.5720, longitude: 6.7930),
                POI(name: "Пешие маршруты Ле-Зарк", category: .activity, latitude: 45.5680, longitude: 6.7850),
                POI(name: "La Folie Douce Les Arcs", category: .food, latitude: 45.5750, longitude: 6.7970),
            ],
            warning: nil,
            fact: "На высоте 1950 метров, где стоит деревня, воздух примерно на 20% разреженнее, чем на уровне моря — многие туристы в первый день здесь замечают лёгкую одышку при подъёме по лестницам, это нормально и проходит за день-два.",
            todayFocus: "Ле-Зарк 1950 — свободный день в деревне и в горах."
        ),

        TripDay(
            id: 20, day: 24, weekday: "Чт", city: .lesArcs, subtitle: "Радиалка в Серравалле",
            intro: nil,
            blocks: [
                PlanBlock(icon: "car.fill", label: "Переезд", text: "Ле-Зарк ⇄ Серравалле: ~302 км / 4 ч 20 мин в одну сторону. Выезд не позже 7:00!"),
                PlanBlock(icon: "sunrise.fill", label: "Утро", text: "Ранний выезд через перевал Пти-Сен-Бернар — дорога сама по себе одна из красивейших поездки: серпантин, долина Аосты, автострада мимо Турина."),
                PlanBlock(icon: "sun.max.fill", label: "День", text: "4–5 часов в Designer Outlet Serravalle — один из крупнейших аутлетов Европы (Gucci, Prada, Moncler, Stone Island и 200+ марок). Выезд обратно не позже 16:30."),
                PlanBlock(icon: "fork.knife", label: "Обед", text: "Фуд-корт аутлета."),
                PlanBlock(icon: "fork.knife", label: "Ужин", text: "По возвращении, поздно — La Vache Rouge в деревне (пицца, тёплая атмосфера) или что-то простое рядом с домом."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Arc 1950, Le Village"),
            ],
            pois: [
                POI(name: "Arc 1950, Le Village", category: .hotel, latitude: 45.5720, longitude: 6.7930),
                POI(name: "Col du Petit-Saint-Bernard", category: .transfer, latitude: 45.6772, longitude: 6.8917),
                POI(name: "Designer Outlet Serravalle", category: .activity, latitude: 44.7647, longitude: 8.8560),
                POI(name: "La Vache Rouge", category: .food, latitude: 45.5715, longitude: 6.7935),
            ],
            warning: "Реальный расчёт по дорогам: 302 км и ~4 ч 20 мин в одну сторону — то есть около 8 ч 40 мин чистой езды туда-обратно за один день, не считая шопинга. Если с утра нет настроения — замените радиалку вторым горным днём и просто останьтесь в деревне: аутлет — опция, а не обязательство. Погоду на перевале проверьте с вечера.",
            fact: nil,
            todayFocus: nil,
            easterEggText: "Пасхалка: где Prada, Gucci и Moncler — там и «Дьявол носит Prada». Проведите день так, будто вы Миранда Пристли, а не турист: с полным равнодушием к ценникам и лёгким презрением ко всем, кто медленно ходит по проходам."
        ),

        // MARK: - ВАЛЛЕ-Д'АОСТА (25–27.09, 2 ночи)

        TripDay(
            id: 21, day: 25, weekday: "Пт", city: .preSaintDidier, subtitle: "Перевал · Аоста · термы",
            intro: """
            Из Франции в Италию через альпийский перевал — термы, римская архитектура, вид на Монблан с другой стороны.

            Ночлег · 2 ночи
            QC Terme Monte Bianco Spa and Resort ★★★★ — €250–390/ночь. Термальный комплекс с видом на Монблан прямо у отеля.
            Residence Villaggio delle Alpi ★★★ — €90–150/ночь. Апарт-отель, 5 мин до подъёмников Courmayeur, бесплатная парковка — хорошо для пикапа.
            """,
            blocks: [
                PlanBlock(icon: "car.fill", label: "Переезд", text: "Ле-Зарк → Пре-Сен-Дидье: ~57 км / 1 ч 30 мин через Col du Petit-Saint-Bernard (2188 м) — проверьте, что перевал открыт"),
                PlanBlock(icon: "sunrise.fill", label: "Утро", text: "Выезд через перевал Пти-Сен-Бернар — одна из самых красивых дорог поездки: альпийские озёра, сурки, панорама на Монблан. Остановитесь на смотровой площадке."),
                PlanBlock(icon: "sun.max.fill", label: "День", text: "Заезд в Аосту (~20 минут от Пре-Сен-Дидье) — древнеримский город: арка Августа, криптопортик."),
                PlanBlock(icon: "fork.knife", label: "Обед", text: "В Аосте, любая trattoria в центре."),
                PlanBlock(icon: "sunset.fill", label: "Вечер", text: "Заселение в Пре-Сен-Дидье, вечерний заход в термы QC Terme."),
                PlanBlock(icon: "fork.knife", label: "Ужин", text: "Le Vieux Pommier — раклет и гноччи алла фондута."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "QC Terme Monte Bianco, Пре-Сен-Дидье"),
            ],
            pois: [
                // Порядок повторяет день: выезд из Arc 1950 через перевал, Аоста, вечером термы.
                POI(name: "Arc 1950, Le Village", category: .hotel, latitude: 45.5720, longitude: 6.7930),
                POI(name: "Col du Petit-Saint-Bernard", category: .transfer, latitude: 45.6772, longitude: 6.8917),
                POI(name: "Аоста, арка Августа", category: .sight, latitude: 45.7372, longitude: 7.3155),
                POI(name: "Аоста, криптопортик", category: .sight, latitude: 45.7369, longitude: 7.3145),
                POI(name: "Отель, Пре-Сен-Дидье", category: .hotel, latitude: 45.7170, longitude: 6.9650),
                POI(name: "Пре-Сен-Дидье", category: .sight, latitude: 45.7186, longitude: 6.9662),
                POI(name: "QC Terme", category: .activity, latitude: 45.7180, longitude: 6.9670),
            ],
            warning: nil,
            fact: "Аоста была основана римлянами в 25 году до н.э. как Augusta Praetoria и до сих пор сохраняет практически нетронутую прямоугольную планировку римского военного лагеря — редкость даже для Италии.",
            todayFocus: nil
        ),

        TripDay(
            id: 22, day: 26, weekday: "Сб", city: .preSaintDidier, subtitle: "Термальный день",
            intro: nil,
            blocks: [
                PlanBlock(icon: "sun.max.fill", label: "День", text: "Целый день в термальном комплексе QC Terme Pré Saint Didier — открытые бассейны с видом на Монблан, сауны, массаж. Слот лучше бронировать заранее — выходной день обычно загружен."),
                PlanBlock(icon: "ticket.fill", label: "Билет", text: "€46–70/чел в зависимости от пакета (день/вечер/5 часов). Фаст-трека нет и очередей как таковых тоже нет — вход строго по забронированному тайм-слоту, не по живой очереди."),
                PlanBlock(icon: "fork.knife", label: "Обед", text: "Можно прямо на территории терм."),
                PlanBlock(icon: "fork.knife", label: "Ужин", text: "Ristorante Baita Ermitage — вид на Монблан, поленту с колбасками."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "QC Terme Monte Bianco, Пре-Сен-Дидье"),
            ],
            pois: [
                POI(name: "Отель, Пре-Сен-Дидье", category: .hotel, latitude: 45.7170, longitude: 6.9650),
                POI(name: "QC Terme", category: .activity, latitude: 45.7180, longitude: 6.9670),
                POI(name: "Ristorante Baita Ermitage", category: .food, latitude: 45.7175, longitude: 6.9700),
            ],
            warning: nil,
            fact: "Термальные источники Пре-Сен-Дидье использовались ещё в античности — древние римляне называли эти места Aquae, и уже тогда ценили именно ту минеральную воду с богатым содержанием сульфатов, на которой работает нынешний комплекс QC Terme.",
            todayFocus: "Пре-Сен-Дидье — свободный термальный день, без переезда."
        ),

        // MARK: - ЛИОН (27.09, финал)

        TripDay(
            id: 23, day: 27, weekday: "Вс", city: .lyon, subtitle: "Пре-Сен-Дидье → Лион",
            intro: """
            Старый город с тайными «трабулями» и лионская кухня на прощание — конечная точка маршрута.

            Если в Лионе останется время
            Рынок Les Halles de Lyon — Paul Bocuse (гастрономический храм города, сыры и устрицы), музей братьев Люмьер на месте, где сняли первый в истории фильм, и квартал Круа-Русс с муралом Mur des Canuts. Парковку у Place Bellecour ищите в подземных паркингах LPA (Q-Park Bellecour) — на улице мест почти нет. Сдать машину в аэропорту можно в тот же вечер.

            Знали ли вы? Vieux Lyon — крупнейший ренессансный квартал Европы после венецианского гетто, признанный ЮНЕСКО в 1998 году. А само слово «бушон» (bouchon), обозначающее лионскую харчевню, изначально значило «пучок соломы»: им в старину отмечали таверны, где путников кормили простой домашней едой и поили местным вином.
            """,
            blocks: [
                PlanBlock(icon: "car.fill", label: "Переезд", text: "Пре-Сен-Дидье → Лион: ~254 км / 3 ч 10 мин через тоннель Мон-Блан (~€45) и Шамони"),
                PlanBlock(icon: "sunrise.fill", label: "Утро", text: "Ранний выезд, чтобы успеть погулять в Лионе днём."),
                PlanBlock(icon: "sun.max.fill", label: "День", text: "Vieux Lyon — знаменитые «трабули» (скрытые проходные дворики, объект ЮНЕСКО), затем Place Bellecour."),
                PlanBlock(icon: "fork.knife", label: "Обед/Ужин", text: "Fiston - Bouchon Lyonnais или LA GÂCHE — классический лионский бушон на прощание."),
                PlanBlock(icon: "sunset.fill", label: "Вечер", text: "Если останутся силы — фуникулёр на холм Фурвьер: базилика и панорама всего города на закате. Отличная финальная точка путешествия. Оттуда же удобно ехать в аэропорт Lyon–Saint-Exupéry на обратный рейс."),
            ],
            pois: [
                // Порядок повторяет день: выезд из Пре-Сен-Дидье, паркинг у Bellecour, прогулка.
                POI(name: "Отель, Пре-Сен-Дидье", category: .hotel, latitude: 45.7170, longitude: 6.9650),
                POI(name: "Паркинг у Place Bellecour", category: .transfer, latitude: 45.7573, longitude: 4.8330),
                POI(name: "Vieux Lyon", category: .sight, latitude: 45.7627, longitude: 4.8272),
                POI(name: "Place Bellecour", category: .sight, latitude: 45.7578, longitude: 4.8320),
                POI(name: "Базилика Фурвьер", category: .sight, latitude: 45.7622, longitude: 4.8226),
                POI(name: "Les Halles de Lyon — Paul Bocuse", category: .food, latitude: 45.7657, longitude: 4.8523),
                POI(name: "Круа-Русс, Mur des Canuts", category: .sight, latitude: 45.7746, longitude: 4.8296),
            ],
            warning: nil,
            fact: "«Трабули» — скрытые сквозные проходы через дворы и лестницы старого Лиона — использовались ткачами шёлка, чтобы переносить готовую ткань между мастерскими и складами в сухую погоду, не выходя на улицу; сегодня сохранилось около 40 таких проходов.",
            todayFocus: nil,
            easterEggText: "Пасхалка: 28 декабря 1895 года именно здесь, в Лионе, братья Люмьер провели первый в истории платный киносеанс — и запустили всё то кино, отсылки на которое ловили вас всю поездку: Гарри Поттер в Уотфорде, «Гадкий я» в Париже, «Код да Винчи» в Лувре, «Залечь на дно в Брюгге» и «Дьявол носит Prada» в Серравалле. Круг замкнулся ровно там, где начался."
        ),
    ]

    static func day(forDayOfMonth day: Int) -> TripDay? {
        allDays.first { $0.day == day }
    }

    /// День поездки, на который приходится календарная дата, — nil вне окна 05–27.09.2026.
    static func day(for date: Date) -> TripDay? {
        let comps = Calendar.current.dateComponents([.year, .month, .day], from: date)
        guard comps.year == 2026, comps.month == 9, let dayOfMonth = comps.day else { return nil }
        return day(forDayOfMonth: dayOfMonth)
    }
}
