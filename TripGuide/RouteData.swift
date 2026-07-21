import Foundation

enum RouteData {
    static let allRoutes: [RouteLeg] = [
        RouteLeg(
            id: 1, dateLabel: "13.09", title: "Лондон → Париж", mode: .train,
            distance: "~2 ч 15 мин", duration: "Евростар",
            roadNote: "St Pancras → Gare du Nord. Билеты — по местному времени отправления, при переезде часы переводятся на +1 час.",
            warning: nil,
            originName: "Лондон, St Pancras", originLat: 51.5308, originLon: -0.1238,
            destinationName: "Париж, Gare du Nord", destLat: 48.8809, destLon: 2.3553,
            // Тоннель под Ла-Маншем: въезд у Фолкстона (UK), выезд у Коккеля (Франция).
            waypoints: [
                RouteWaypoint(name: "Евротоннель, въезд (Фолкстон)", lat: 51.0854, lon: 1.1418),
                RouteWaypoint(name: "Евротоннель, выезд (Коккель)", lat: 50.9268, lon: 1.7836),
            ]
        ),
        RouteLeg(
            id: 2, dateLabel: "17.09", title: "Диснейленд → Брюгге", mode: .car,
            distance: "~307 км", duration: "3 ч 30 мин",
            roadNote: "На север в объезд Парижа по A1/E15/E17. Границу Франция–Бельгия проезжаете без контроля (Шенген).",
            warning: "Первый из двух самых длинных дней подряд — на следующий день ещё 614 км до Бона.",
            originName: "Диснейленд (Marne-la-Vallée)", originLat: 48.8703, originLon: 2.7766,
            destinationName: "Брюгге, Markt", destLat: 51.2085, destLon: 3.2247
        ),
        RouteLeg(
            id: 3, dateLabel: "18.09", title: "Брюгге → Бон", mode: .car,
            distance: "~614 км", duration: "6 ч 20 мин",
            roadNote: "A26 вдоль Реймса (стоит сделать остановку у собора Notre-Dame de Reims), дальше через Труа и Лангр до Бона.",
            warning: "Самый длинный день за рулём во всей поездке — почти 7 часов чистой езды. Меняйтесь за рулём каждые 2 часа. При усталости разбейте ночёвкой в Реймсе.",
            originName: "Брюгге, Markt", originLat: 51.2085, originLon: 3.2247,
            destinationName: "Бон, старый город", destLat: 47.0235, destLon: 4.8358,
            waypoints: [
                RouteWaypoint(name: "Собор Notre-Dame de Reims", lat: 49.2533, lon: 4.0347),
            ]
        ),
        RouteLeg(
            id: 4, dateLabel: "19.09", title: "Бон → Анси", mode: .car,
            distance: "~233 км", duration: "2 ч 45 мин",
            roadNote: "A6 → A40 через Bourg-en-Bresse — не через Женеву! На навигаторе иногда предлагает маршрут через Швейцарию (нужна платная виньетка ~40 CHF).",
            warning: nil,
            originName: "Бон, старый город", originLat: 47.0235, originLon: 4.8358,
            destinationName: "Анси, старый город", destLat: 45.8992, destLon: 6.1294
        ),
        RouteLeg(
            id: 5, dateLabel: "20.09", title: "Анси → Шамони", mode: .car,
            distance: "~99 км", duration: "1 ч 20 мин",
            roadNote: "A41 → A40, горные виды в конце пути.",
            warning: nil,
            originName: "Анси, старый город", originLat: 45.8992, originLon: 6.1294,
            destinationName: "Шамони, центр", destLat: 45.9237, destLon: 6.8694
        ),
        RouteLeg(
            id: 6, dateLabel: "22.09", title: "Шамони → Ле-Зарк 1950", mode: .car,
            distance: "~120 км", duration: "2 ч",
            roadNote: "N90 через Bourg-Saint-Maurice, серпантин в конце подъёма к деревне.",
            warning: nil,
            originName: "Шамони, центр", originLat: 45.9237, originLon: 6.8694,
            destinationName: "Arc 1950, Le Village", destLat: 45.5720, destLon: 6.7930
        ),
        RouteLeg(
            id: 7, dateLabel: "24.09", title: "Ле-Зарк ⇄ Серравалле (радиалка)", mode: .car,
            distance: "~302 км", duration: "4 ч 20 мин в одну сторону",
            roadNote: "Через перевал Col du Petit-Saint-Bernard, долину Аосты и автостраду мимо Турина.",
            warning: "Около 8 ч 40 мин чистой езды туда-обратно за один день. Выезд не позже 7:00, обратно не позже 16:30. Погоду на перевале проверьте с вечера.",
            originName: "Arc 1950, Le Village", originLat: 45.5720, originLon: 6.7930,
            destinationName: "Designer Outlet Serravalle", destLat: 44.7647, destLon: 8.8560,
            waypoints: [
                RouteWaypoint(name: "Col du Petit-Saint-Bernard", lat: 45.6772, lon: 6.8917),
            ]
        ),
        RouteLeg(
            id: 8, dateLabel: "25.09", title: "Ле-Зарк → Пре-Сен-Дидье", mode: .car,
            distance: "~57 км", duration: "1 ч 30 мин",
            roadNote: "Через Col du Petit-Saint-Bernard (2188 м) — проверьте, что перевал открыт. Запасной путь при закрытии — тоннель Мон-Блан.",
            warning: nil,
            originName: "Arc 1950, Le Village", originLat: 45.5720, originLon: 6.7930,
            destinationName: "Пре-Сен-Дидье", destLat: 45.7186, destLon: 6.9662,
            waypoints: [
                RouteWaypoint(name: "Col du Petit-Saint-Bernard", lat: 45.6772, lon: 6.8917),
            ]
        ),
        RouteLeg(
            id: 9, dateLabel: "27.09", title: "Пре-Сен-Дидье → Лион", mode: .car,
            distance: "~254 км", duration: "3 ч 10 мин",
            roadNote: "Тоннель Мон-Блан (~€45) через Шамони, дальше A40 → A42.",
            warning: nil,
            originName: "Пре-Сен-Дидье", originLat: 45.7186, originLon: 6.9662,
            destinationName: "Лион, Vieux Lyon", destLat: 45.7627, destLon: 4.8272,
            // Через тоннель Мон-Блан — MKDirections иначе может выбрать объездной маршрут.
            waypoints: [
                RouteWaypoint(name: "Шамони (тоннель Мон-Блан)", lat: 45.9237, lon: 6.8694),
            ]
        ),
    ]
}
