import Foundation

// Данные путеводителя "Лондон → Лион" v2 — 22 дня, 05–26 сентября 2026.
// Один город/точка на маршруте = один "intro" (показывается на первый день пребывания).

enum TripData {

    static let allDays: [TripDay] = [

        // MARK: - ЛОНДОН (05–13.09, 8 ночей)

        TripDay(
            id: 1, day: 5, weekday: "Сб", city: .london, subtitle: "Прилёт · Portobello",
            intro: """
            Столица открывает маршрут — восемь дней без машины, пешком и на метро (аренда авто только на день в Котсуолдс).

            Ночлег · 7 ночей, Хаммерсмит
            5 Stanwick Road, W14 8TL (Hammersmith & Fulham). До центра ~20–30 мин на метро (District/Piccadilly). Отдельно 09.09 — одна ночь в Берфорде (Котсуолдс).
            """,
            blocks: [
                PlanBlock(icon: "sun.max.fill", label: "День", text: "~14:00–15:00 · Прилёт, заселение на Stanwick Road, разбор вещей без спешки после перелёта."),
                PlanBlock(icon: "figure.walk", label: "Прогулка", text: "16:00–18:00 · Portobello Road (Ноттинг-Хилл) — антиквариат, винтаж, стрит-фуд. ~15 минут от отеля."),
                PlanBlock(icon: "fork.knife", label: "Ужин", text: "18:30 · Shake Shack в Westfield London (Shepherd's Bush) — 10 минут от рынка, сытно и без брони."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Хаммерсмит"),
            ],
            pois: [
                POI(name: "Отель, Хаммерсмит", category: .hotel, latitude: 51.4906, longitude: -0.2058),
                POI(name: "Portobello Road Market", category: .activity, latitude: 51.5165, longitude: -0.2055),
                POI(name: "Shake Shack, Westfield London", category: .food, latitude: 51.5079, longitude: -0.2246),
            ],
            warning: nil,
            fact: "Portobello Road — самый длинный антикварный рынок под открытым небом в мире, растянувшийся почти на 1,6 км; название улице дала не итальянская гавань, а ферма XVIII века, названная в честь взятия панамского порта Portobelo в 1739 году.",
            todayFocus: "Лёгкий день после перелёта: Portobello и ужин рядом."
        ),

        TripDay(
            id: 2, day: 6, weekday: "Вс", city: .london, subtitle: "Вестминстер · Arsenal–Chelsea",
            intro: nil,
            blocks: [
                PlanBlock(icon: "sunrise.fill", label: "Утро", text: "10:00–11:30 · Национальная галерея к открытию. Level 2, залы 43–46: импрессионизм и постимпрессионизм; зал 45 — истоки авангарда (Дега, Климт, Сезанн, Матисс). Залы 40 и 42 можно пропустить."),
                PlanBlock(icon: "fork.knife", label: "Обед", text: "11:30–12:30 · Трафальгарская площадь, затем пикник в Сент-Джеймсском парке — meal deal из ближайшего Tesco/Sainsbury's."),
                PlanBlock(icon: "sun.max.fill", label: "День", text: "12:30–14:00 · Букингемский дворец → конная гвардия у Уайтхолла (Horse Guards Parade) → проходим мимо Вестминстерского аббатства и Биг-Бена."),
                PlanBlock(icon: "sportscourt.fill", label: "Футбол", text: "14:45 · выезд к Emirates Stadium (~30–40 мин, Piccadilly line до Arsenal). 15:30 — у стадиона, 16:30 — Arsenal–Chelsea."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Хаммерсмит"),
            ],
            pois: [
                POI(name: "Отель, Хаммерсмит", category: .hotel, latitude: 51.4906, longitude: -0.2058),
                POI(name: "Национальная галерея", category: .sight, latitude: 51.5089, longitude: -0.1283),
                POI(name: "Трафальгарская площадь", category: .sight, latitude: 51.5080, longitude: -0.1281),
                POI(name: "Сент-Джеймсский парк", category: .activity, latitude: 51.5027, longitude: -0.1329),
                POI(name: "Букингемский дворец", category: .sight, latitude: 51.5014, longitude: -0.1419),
                POI(name: "Horse Guards Parade", category: .sight, latitude: 51.5043, longitude: -0.1266),
                POI(name: "Вестминстерское аббатство (снаружи)", category: .sight, latitude: 51.4994, longitude: -0.1273),
                POI(name: "Emirates Stadium", category: .activity, latitude: 51.5549, longitude: -0.1084),
            ],
            warning: "Смена конного караула у Horse Guards в 10:00 (вс) совпадает с открытием Национальной галереи — придётся выбрать одно; конные часовые всё равно стоят там весь день.",
            fact: "«Биг-Бен» — имя большого колокола, а не башни целиком; сама башня официально называется Elizabeth Tower с 2012 года, в честь бриллиантового юбилея Елизаветы II. Колокол весит около 13,7 тонны.",
            todayFocus: "Вестминстер утром, вечером — дерби Arsenal–Chelsea на Emirates."
        ),

        TripDay(
            id: 3, day: 7, weekday: "Пн", city: .london, subtitle: "Тауэр · Гринвич",
            intro: nil,
            blocks: [
                PlanBlock(icon: "sunrise.fill", label: "Утро", text: "09:30–12:00 · Тауэр Лондона (открытие 09:00), затем прогулка по Тауэрскому мосту."),
                PlanBlock(icon: "ticket.fill", label: "Билет", text: "Тауэр Лондона — €65–80 за двоих по тайм-слоту. Фаст-трека нет: без брони очередь на входе/досмотре 30–60 минут в сезон, по забронированному слоту — 10–15 минут."),
                PlanBlock(icon: "fork.knife", label: "Обед", text: "12:15 · Borough Market (по желанию — небольшой крюк на запад; можно пропустить, если день выходит плотным)."),
                PlanBlock(icon: "sun.max.fill", label: "День", text: "13:00 · кораблик по Темзе Тауэр→Гринвич (~45 мин) → Cutty Sark → 15:00 Королевская обсерватория (нулевой меридиан)."),
                PlanBlock(icon: "ticket.fill", label: "Билеты", text: "Кораблик Тауэр→Гринвич — €28–40 за двоих, фаст-трека нет, но с онлайн-билетом посадка почти сразу (без брони у кассы можно потерять 20–30 минут). Королевская обсерватория (линия Гринвичского меридиана + экспозиция) — €46–52 за двоих по тайм-слоту, очередей практически нет."),
                PlanBlock(icon: "fork.knife", label: "Ужин", text: "Bill's Greenwich или Hawksmoor Wood Wharf."),
                PlanBlock(icon: "wineglass.fill", label: "Вечер", text: "На обратном пути (DLR до Westferry/Limehouse) — The Grapes, крошечный паб на набережной Темзы, стоит здесь с 1583 года. Совладелец — Иэн Маккеллен, живёт на этой же улице; по понедельникам с 20:00 тут знаменитый паб-квиз, который он иногда ведёт сам. Столы не бронируют — приходите заранее."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Хаммерсмит"),
            ],
            pois: [
                POI(name: "Отель, Хаммерсмит", category: .hotel, latitude: 51.4906, longitude: -0.2058),
                POI(name: "Тауэр Лондона", category: .sight, latitude: 51.5081, longitude: -0.0759),
                POI(name: "Тауэрский мост", category: .sight, latitude: 51.5055, longitude: -0.0754),
                POI(name: "Borough Market", category: .food, latitude: 51.5055, longitude: -0.0910),
                POI(name: "Cutty Sark", category: .sight, latitude: 51.4826, longitude: -0.0077),
                POI(name: "Королевская обсерватория, Гринвич", category: .sight, latitude: 51.4769, longitude: -0.0005),
                POI(name: "The Grapes, Лаймхаус", category: .food, latitude: 51.5092, longitude: -0.0370),
            ],
            warning: "Самый насыщенный день в Лондоне (≈09:00–21:00). Чтобы разгрузить — можно пропустить Borough Market. Разведение Тауэрского моста бывает по расписанию (несколько раз в неделю) — сверьтесь заранее, если хотите застать.",
            fact: "Гринвичская обсерватория стоит точно на нулевом меридиане — можно встать одной ногой в Западном, а другой в Восточном полушарии. Именно отсюда отсчитывается всемирное время (GMT).",
            todayFocus: "Тауэр, Тауэрский мост и Гринвич по Темзе; вечером — The Grapes."
        ),

        TripDay(
            id: 4, day: 8, weekday: "Вт", city: .london, subtitle: "Harry Potter Studio Tour",
            intro: nil,
            blocks: [
                PlanBlock(icon: "sun.max.fill", label: "День", text: "Поезд Хаммерсмит → Watford Junction (~40–50 мин) + шаттл к студии. Целиком на Warner Bros. Studio Tour — тайм-слот тура, закладывайте 3–4 часа."),
                PlanBlock(icon: "ticket.fill", label: "Билет", text: "£58.50 (~€68) с человека, вход строго по забронированному тайм-слоту. Отдельного фаст-трека нет и не нужен — с билетом на входе ждать около 15 минут в любом случае."),
                PlanBlock(icon: "fork.knife", label: "Обед", text: "Кафе на территории студии (Backlot Café)."),
                PlanBlock(icon: "sunset.fill", label: "Вечер", text: "Возврат в центр, свободный вечер — можно просто отдохнуть у отеля."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Хаммерсмит"),
            ],
            pois: [
                // Порядок повторяет день: поезд до Watford Junction, оттуда шаттл к студии.
                POI(name: "Отель, Хаммерсмит", category: .hotel, latitude: 51.4906, longitude: -0.2058),
                POI(name: "Watford Junction", category: .transfer, latitude: 51.6634, longitude: -0.3958),
                POI(name: "Warner Bros. Studio Tour", category: .activity, latitude: 51.6925, longitude: -0.4165),
            ],
            warning: nil,
            fact: "Диагон-аллею для фильмов о Гарри Поттере строили как настоящую улицу в натуральную величину и до сих пор используют декорацию без изменений — фасады снимали с реальных исторических зданий Лондона.",
            todayFocus: "Студия Warner Bros в Уотфорде, ~30 км к северо-западу.",
            easterEggText: "Пасхалка: пройдите весь тур, представляя, что письмо из Хогвартса просто задержалось в пути лет на двадцать. И обязательно закажите Butterbeer в кафе Backlot — рецепт держат в секрете, но на вкус подозрительно похоже на сливочную пенку с ирисками."
        ),

        TripDay(
            id: 5, day: 9, weekday: "Ср", city: .london, subtitle: "Котсуолдс · паб Кларксона · Берфорд",
            intro: nil,
            blocks: [
                PlanBlock(icon: "car.fill", label: "День", text: "Утром забираете арендованную машину, выезд в Оксфордшир (~2 ч из Хаммерсмита). По пути — Bourton-on-the-Water с мостами через реку Уиндраш. Бронь в пабе обязательна, закрыт вс/пн."),
                PlanBlock(icon: "fork.knife", label: "Обед", text: "The Farmer's Dog — паб Джереми Кларксона в Astall. Стейк-пай и раклет-крамбл — фирменные блюда."),
                PlanBlock(icon: "sunset.fill", label: "Вечер", text: "Берфорд — один из красивейших городков Котсуолдса: медово-жёлтые известняковые фасады на High Street, антикварные лавки, мост через реку Уиндраш."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Prince of Burford, Берфорд"),
                PlanBlock(icon: "map.fill", label: "Маршрут", text: "Хаммерсмит → Котсуолдс → Берфорд, ~135 км / ~2 ч на арендованной машине."),
            ],
            pois: [
                // Отель — стартовая точка дня: от него строится маршрут до паба и далее в Берфорд.
                POI(name: "Отель, Хаммерсмит", category: .hotel, latitude: 51.4906, longitude: -0.2058),
                POI(name: "Bourton-on-the-Water", category: .sight, latitude: 51.8767, longitude: -1.7530),
                POI(name: "The Farmer's Dog, Astall", category: .food, latitude: 51.8020, longitude: -1.6230),
                POI(name: "Prince of Burford, Берфорд", category: .hotel, latitude: 51.8103, longitude: -1.6360),
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
                PlanBlock(icon: "car.fill", label: "Утро", text: "Завтрак в Берфорде, прогулка по историческому High Street, выезд обратно в Лондон (~135 км / ~2 ч), сдача арендованной машины."),
                PlanBlock(icon: "sunrise.fill", label: "День", text: "12:00–14:00 · Британский музей (бесплатно). Египет: зал 4 (скульптура) и залы 61–66 (мумии, загробный мир); Месопотамия и Ассирия — залы 6–10."),
                PlanBlock(icon: "sun.max.fill", label: "Прогулка", text: "14:30 · Сохо, флагман Stone Island на 79 Brewer St."),
                PlanBlock(icon: "fork.knife", label: "Ужин", text: "16:30 · Blacklock Soho — стейк-хаус."),
                PlanBlock(icon: "wineglass.fill", label: "Вечер", text: "18:00–20:00 · экскурсия «Вековые пабы Лондона» — старт у Blue Plaque (Christ's Hospital, EC1A 7BA)."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Хаммерсмит"),
            ],
            pois: [
                POI(name: "Prince of Burford, Берфорд", category: .hotel, latitude: 51.8103, longitude: -1.6360),
                POI(name: "Британский музей", category: .sight, latitude: 51.5194, longitude: -0.1270),
                POI(name: "Сохо", category: .sight, latitude: 51.5136, longitude: -0.1367),
                POI(name: "Stone Island, 79 Brewer St", category: .activity, latitude: 51.5129, longitude: -0.1365),
                POI(name: "Blacklock Soho", category: .food, latitude: 51.5128, longitude: -0.1329),
                POI(name: "Паб-экскурсия (старт)", category: .activity, latitude: 51.5163, longitude: -0.0990),
            ],
            warning: "Плотный день: утренний перегон из Берфорда + музей + вечерняя паб-экскурсия. По музею — только ключевые залы, чтобы успеть к 18:00.",
            fact: "Британский музей был первым в мире национальным публичным музеем (открыт в 1753 году) и с самого начала задумывался как бесплатный для всех посетителей — этот принцип соблюдается до сих пор.",
            todayFocus: "Британский музей, Сохо и вечерняя экскурсия по историческим пабам."
        ),

        TripDay(
            id: 7, day: 11, weekday: "Пт", city: .london, subtitle: "Camden · Little Venice",
            intro: nil,
            blocks: [
                PlanBlock(icon: "sunrise.fill", label: "Утро", text: "11:00 · бранч в Coretto by the Canal — шампань-бранч у канала."),
                PlanBlock(icon: "sun.max.fill", label: "День", text: "12:30 · Camden Market и Camden Locks — еда, винтаж, шлюзы канала."),
                PlanBlock(icon: "figure.walk", label: "Прогулка", text: "14:00 · вдоль Regent's Canal на запад → Little Venice."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Хаммерсмит"),
            ],
            pois: [
                POI(name: "Отель, Хаммерсмит", category: .hotel, latitude: 51.4906, longitude: -0.2058),
                POI(name: "Coretto by the Canal", category: .food, latitude: 51.5405, longitude: -0.1400),
                POI(name: "Camden Market", category: .activity, latitude: 51.5416, longitude: -0.1462),
                POI(name: "Camden Locks", category: .activity, latitude: 51.5407, longitude: -0.1440),
                POI(name: "Regent's Canal", category: .sight, latitude: 51.5290, longitude: -0.1730),
                POI(name: "Little Venice", category: .sight, latitude: 51.5210, longitude: -0.1830),
            ],
            warning: nil,
            fact: "Camden Market вырос из одной небольшой ремесленной ярмарки 1974 года на месте бывших конюшен и сегодня принимает около 250 000 посетителей в неделю — это один из самых посещаемых рынков мира.",
            todayFocus: "Лёгкий день: бранч у канала, Camden и прогулка до Little Venice."
        ),

        TripDay(
            id: 8, day: 12, weekday: "Сб", city: .london, subtitle: "Хаммерсмит · парки · London Eye",
            intro: nil,
            blocks: [
                PlanBlock(icon: "sunrise.fill", label: "Утро", text: "11:00 · бранч в The Truth (Хаммерсмит), в двух шагах от отеля."),
                PlanBlock(icon: "sun.max.fill", label: "День", text: "12:30 · Кенсингтон-гарденс → Гайд-парк, неспешная прогулка по паркам."),
                PlanBlock(icon: "sunset.fill", label: "Вечер", text: "17:30 · London Eye на закате — прощальный вид на Вестминстер и Темзу."),
                PlanBlock(icon: "ticket.fill", label: "Билет", text: "London Eye — €65–95 за двоих (стандартный слот). Fast Track — доплата ~€45–55; без него очередь 20–40 минут в разгар дня, с ним ~5 минут."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Хаммерсмит"),
            ],
            pois: [
                POI(name: "Отель, Хаммерсмит", category: .hotel, latitude: 51.4906, longitude: -0.2058),
                POI(name: "The Truth, Хаммерсмит", category: .food, latitude: 51.4918, longitude: -0.2235),
                POI(name: "Кенсингтон-гарденс", category: .activity, latitude: 51.5073, longitude: -0.1799),
                POI(name: "Гайд-парк", category: .activity, latitude: 51.5073, longitude: -0.1657),
                POI(name: "London Eye", category: .sight, latitude: 51.5033, longitude: -0.1195),
            ],
            warning: nil,
            fact: "London Eye строили как временную конструкцию к миллениуму 2000 года — колесо должно было простоять всего пять лет, но оказалось настолько популярным, что стало постоянным символом города.",
            todayFocus: "Последний лондонский день: бранч, парки и London Eye на закате."
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

        // MARK: - БУРГУНДИЯ · БОН (17–18.09, 1 ночь)

        TripDay(
            id: 13, day: 17, weekday: "Чт", city: .beaune, subtitle: "Диснейленд → Бон",
            intro: """
            Средневековый центр и родина бургундского вина — по пути из Парижского региона на юг, к Альпам.

            Ночлег · 1 ночь, исторический центр
            Le Central Boutique-Hôtel ★★★ — €90–229/ночь. Напротив Hospices de Beaune, здание бывшей почтовой станции.

            Парковка в Боне
            Старый город не рассчитан на 6-метровый пикап. Зона для крупных автомобилей — Avenue de la Liberté (бесплатно первые 4 часа), либо один из муниципальных паркингов чуть дальше от центра. До отеля и Hospices оттуда 10 минут пешком.
            """,
            blocks: [
                PlanBlock(icon: "car.fill", label: "Переезд", text: "Диснейленд → Бон: ~330 км / 3 ч 30 мин по A5/A6 через Шампань и Труа."),
                PlanBlock(icon: "sunrise.fill", label: "Утро", text: "Забираете машину у Диснейленда, выезжаете на юг. Заправьтесь GPL заранее — на трассе станций немного."),
                PlanBlock(icon: "sunset.fill", label: "Вечер", text: "Прибытие в Бон, неспешная прогулка по средневековому центру — крепостные стены, базилика Нотр-Дам с готическими гобеленами."),
                PlanBlock(icon: "fork.knife", label: "Ужин", text: "Caves Madeleine (дегустационное меню, общий стол) или Restaurant Au Coq Bleu."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Le Central Boutique-Hôtel, Бон"),
            ],
            pois: [
                // Порядок повторяет день: выезд от отеля у Диснейленда, вечер в Боне.
                POI(name: "Отель у парков", category: .hotel, latitude: 48.8670, longitude: 2.7810),
                POI(name: "Отель, Бон", category: .hotel, latitude: 47.0238, longitude: 4.8385),
                POI(name: "Старый город, Бон", category: .sight, latitude: 47.0235, longitude: 4.8358),
                POI(name: "Hospices de Beaune", category: .sight, latitude: 47.0242, longitude: 4.8395),
            ],
            warning: nil,
            fact: "Разноцветная черепичная крыша Hospices de Beaune, ставшая символом Бургундии, была уложена в XV веке фламандскими мастерами — тот же геометрический стиль узоров пришёл во французскую Бургундию из Фландрии.",
            todayFocus: nil
        ),

        // MARK: - АНСИ (18–19.09, 1 ночь)

        TripDay(
            id: 14, day: 18, weekday: "Пт", city: .annecy, subtitle: "Бон → Анси",
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

        // MARK: - ШАМОНИ (19–21.09, 2 ночи)

        TripDay(
            id: 15, day: 19, weekday: "Сб", city: .chamonix, subtitle: "Aiguille du Midi",
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
            id: 16, day: 20, weekday: "Вс", city: .chamonix, subtitle: "Ледник Мер-де-Глас",
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

        // MARK: - ЛЕ-ЗАРК 1950 (21–24.09, 3 ночи)

        TripDay(
            id: 17, day: 21, weekday: "Пн", city: .lesArcs, subtitle: "Заселение",
            intro: """
            Главная точка отдыха в горах — пешеходная деревня в стиле савойского шале на высоте 1950 м. Три ночи здесь, а дальше — через аутлет Серравалле в Турин.

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
            id: 18, day: 22, weekday: "Вт", city: .lesArcs, subtitle: "Горный день",
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
            id: 19, day: 23, weekday: "Ср", city: .lesArcs, subtitle: "Спокойный день в деревне",
            intro: nil,
            blocks: [
                PlanBlock(icon: "sunrise.fill", label: "Утро", text: "Без спешки: завтрак в деревне, неспешная прогулка по пешеходным улочкам Arc 1950. Завтра ранний старт в Италию — сегодня набираемся сил."),
                PlanBlock(icon: "figure.hiking", label: "День", text: "По желанию — кабинка Cabriolet des Villages наверх, к Arc 2000, и подъёмник Aiguille Rouge (3226 м) за панорамой на Монблан (в сентябре подъёмники работают в ограниченном режиме — уточните расписание). Либо просто спа и бассейн в резиденции."),
                PlanBlock(icon: "fork.knife", label: "Обед", text: "Chalet de l'Arcelle или терраса в деревне с видом на долину."),
                PlanBlock(icon: "bag.fill", label: "Сборы", text: "Соберите чемоданы и загрузите машину с вечера: завтра ранний выезд через Монблан в аутлет и дальше в Турин."),
                PlanBlock(icon: "fork.knife", label: "Ужин", text: "La Vache Rouge — пицца и тёплая атмосфера, либо L'Arpette в деревне."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "Arc 1950, Le Village (последняя ночь)"),
            ],
            pois: [
                // Всё в пешей доступности внутри пешеходной деревни Arc 1950.
                POI(name: "Arc 1950, Le Village", category: .hotel, latitude: 45.5720, longitude: 6.7930),
                POI(name: "Cabriolet des Villages", category: .activity, latitude: 45.5735, longitude: 6.7958),
                POI(name: "La Vache Rouge", category: .food, latitude: 45.5712, longitude: 6.7942),
            ],
            warning: nil,
            fact: "Подъёмник Aiguille Rouge поднимает на 3226 м — это высшая доступная точка курорта Ле-Арк, откуда в ясную погоду виден весь массив Монблана и даже Маттерхорн на горизонте.",
            todayFocus: "Ле-Зарк 1950 — последний спокойный день перед броском в Италию."
        ),

        // MARK: - ТУРИН (24–26.09, 2 ночи)

        TripDay(
            id: 20, day: 24, weekday: "Чт", city: .turin, subtitle: "Монблан · аутлет → Турин",
            intro: """
            Большой день-переход из Альп в первую столицу Италии: утром — Монблан с итальянской стороны, потом шопинг-привал и вечером Турин.

            Ночлег · 2 ночи, центр Турина
            NH Collection Torino Piazza Carlina ★★★★ — €160–260/ночь. Историческое палаццо на Piazza Carlina, 10 минут пешком до Моле и Egizio.
            Turin Palace Hotel ★★★★★ — €220–360/ночь. Классика напротив вокзала Porta Nuova, крытый паркинг рядом — удобно для пикапа.
            """,
            blocks: [
                PlanBlock(icon: "car.fill", label: "Переезд", text: "Ле-Зарк → Курмайёр → аутлет Серравалле → Турин: ~410 км суммарно. Выезд очень ранний, не позже 6:30."),
                PlanBlock(icon: "mountain.2.fill", label: "Утро", text: "Через перевал Пти-Сен-Бернар в Курмайёр, к станции Skyway Monte Bianco. Вращающиеся стеклянные кабины до Punta Helbronner (3466 м): круговая терраса 360° почти у вершины Монблана, ледник Гигант, вид на Маттерхорн. Берите ранний слот, ~€57/чел, одевайтесь теплее — наверху около нуля."),
                PlanBlock(icon: "bag.fill", label: "День", text: "Дальше на юг (~2 ч 30 мин) в Designer Outlet Serravalle — один из крупнейших аутлетов Европы (Gucci, Prada, Moncler, Stone Island и 200+ марок), 2–3 часа на шопинг."),
                PlanBlock(icon: "fork.knife", label: "Обед", text: "На панорамной станции Skyway (Pavillon) или в фуд-корте аутлета."),
                PlanBlock(icon: "sunset.fill", label: "Вечер", text: "~1 ч 10 мин на север в Турин, заселение в центре. Вечерний аперитиво (изобретён именно здесь) на Piazza Vittorio Veneto."),
                PlanBlock(icon: "fork.knife", label: "Ужин", text: "Ristorante Consorzio — пьемонтская классика: вителло тоннато, аньолотти дель плин."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "NH Collection Piazza Carlina, Турин"),
            ],
            pois: [
                // Порядок повторяет день: перевал, Skyway у Курмайёра, аутлет, вечером Турин.
                POI(name: "Arc 1950, Le Village", category: .hotel, latitude: 45.5720, longitude: 6.7930),
                POI(name: "Col du Petit-Saint-Bernard", category: .transfer, latitude: 45.6772, longitude: 6.8917),
                POI(name: "Skyway Monte Bianco (Курмайёр)", category: .activity, latitude: 45.7963, longitude: 6.9645),
                POI(name: "Designer Outlet Serravalle", category: .activity, latitude: 44.7647, longitude: 8.8560),
                POI(name: "Отель, Турин", category: .hotel, latitude: 45.0685, longitude: 7.6830),
            ],
            warning: "Очень длинный день: Skyway (2–3 ч), шопинг и ~6 часов за рулём. Реально успеть только с ранним выездом и коротким слотом на Skyway — если утро на Монблане затянется, сократите аутлет или пропустите его. Погоду на перевале и наверху проверьте с вечера; при закрытии перевала — тоннель Фрежюс из Модана.",
            fact: "Skyway Monte Bianco (2015) — кабины медленно вращаются вокруг оси на всём подъёме, так что за одну поездку видно панораму на все 360°: от вершины Монблана до итальянских Альп. Верхняя станция Punta Helbronner — 3466 м.",
            todayFocus: nil,
            easterEggText: "Пасхалка: где Prada, Gucci и Moncler — там и «Дьявол носит Prada». Проведите пару часов в аутлете так, будто вы Миранда Пристли, а не турист: с полным равнодушием к ценникам и лёгким презрением ко всем, кто медленно ходит по проходам."
        ),

        TripDay(
            id: 21, day: 25, weekday: "Пт", city: .turin, subtitle: "Прогулка по Турину",
            intro: nil,
            blocks: [
                PlanBlock(icon: "building.columns.fill", label: "Утро", text: "Египетский музей (Museo Egizio) — второе по величине собрание древнеегипетского искусства в мире после Каира. Билеты берите онлайн по тайм-слоту, закладывайте 2–2,5 часа."),
                PlanBlock(icon: "fork.knife", label: "Кофе", text: "Историческое кафе Al Bicerin или Baratti & Milano — местный биричин (кофе, шоколад и сливки) и туринский джандуйотто."),
                PlanBlock(icon: "sun.max.fill", label: "День", text: "Piazza San Carlo — «гостиная Турина» с аркадами, затем Piazza Castello и Palazzo Reale с королевской оружейной палатой. По желанию — Королевский дворец и сады."),
                PlanBlock(icon: "sunset.fill", label: "Вечер", text: "Моле-Антонеллиана — символ города: Национальный музей кино внутри и панорамный лифт со стеклянной кабиной прямо сквозь купол на смотровую (85 м). Отличный закат над Альпами."),
                PlanBlock(icon: "fork.knife", label: "Ужин", text: "Eataly Lingotto или траттория в квартале Quadrilatero Romano."),
                PlanBlock(icon: "bed.double.fill", label: "Ночлег", text: "NH Collection Piazza Carlina, Турин"),
            ],
            pois: [
                // Компактный пеший маршрут по историческому центру.
                POI(name: "Отель, Турин", category: .hotel, latitude: 45.0685, longitude: 7.6830),
                POI(name: "Piazza San Carlo", category: .sight, latitude: 45.0678, longitude: 7.6825),
                POI(name: "Египетский музей (Museo Egizio)", category: .sight, latitude: 45.0681, longitude: 7.6844),
                POI(name: "Piazza Castello · Palazzo Reale", category: .sight, latitude: 45.0709, longitude: 7.6858),
                POI(name: "Моле-Антонеллиана · Музей кино", category: .sight, latitude: 45.0690, longitude: 7.6934),
            ],
            warning: nil,
            fact: "Именно в Турине в 1786 году Антонио Бенедетто Карпано изобрёл вермут, а чуть позже здесь же придумали хлебные палочки гриссини — так что аперитиво в туринском кафе это буквально дегустация на его исторической родине.",
            todayFocus: "Турин — целый день пешком по центру, без переезда."
        ),

        // MARK: - ЛИОН (26.09, вылет)

        TripDay(
            id: 22, day: 26, weekday: "Сб", city: .lyon, subtitle: "Турин → Лион · вылет",
            intro: """
            Финальный отрезок — перегон из Турина обратно во Францию, в аэропорт Лиона к рейсу домой.

            Рейс из Лиона
            Программа — по минимуму: главное успеть к самолёту. Ранний выезд из Турина, чтобы с запасом добраться до аэропорта.
            """,
            blocks: [
                PlanBlock(icon: "car.fill", label: "Переезд", text: "Турин → аэропорт Лион-Сент-Экзюпери: ~305 км / 3 ч 30 мин через тоннель Фрежюс (~€48) и долину Морьен."),
                PlanBlock(icon: "sunrise.fill", label: "Утро", text: "Ранний выезд из Турина, сдача арендованной машины в аэропорту."),
                PlanBlock(icon: "airplane.departure", label: "Вылет", text: "Рейс домой из Лион-Сент-Экзюпери (LYS)."),
            ],
            pois: [
                POI(name: "Отель, Турин", category: .hotel, latitude: 45.0685, longitude: 7.6830),
                POI(name: "Аэропорт Лион-Сент-Экзюпери (LYS)", category: .transfer, latitude: 45.7256, longitude: 5.0811),
            ],
            warning: nil,
            fact: "Именно в Лионе 28 декабря 1895 года братья Люмьер провели первый в истории платный киносеанс — город считается родиной кинематографа.",
            todayFocus: nil,
            easterEggText: "Пасхалка: именно в Лионе братья Люмьер провели первый в истории киносеанс — и запустили всё то кино, отсылки на которое ловили вас всю поездку: Гарри Поттер в Уотфорде, «Гадкий я» в Париже, «Код да Винчи» в Лувре, «Дьявол носит Prada» в Серравалле. Круг замкнулся там, где начался."
        ),
    ]

    static func day(forDayOfMonth day: Int) -> TripDay? {
        allDays.first { $0.day == day }
    }

    /// День поездки, на который приходится календарная дата, — nil вне окна 05–26.09.2026.
    static func day(for date: Date) -> TripDay? {
        let comps = Calendar.current.dateComponents([.year, .month, .day], from: date)
        guard comps.year == 2026, comps.month == 9, let dayOfMonth = comps.day else { return nil }
        return day(forDayOfMonth: dayOfMonth)
    }
}
