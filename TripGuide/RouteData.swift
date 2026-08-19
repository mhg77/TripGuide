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
            id: 2, dateLabel: "17.09", title: "Диснейленд → Бон", mode: .car,
            distance: "~330 км", duration: "3 ч 30 мин",
            roadNote: "A5/A6 в объезд Парижа через Шампань и Труа до Бургундии.",
            warning: nil,
            originName: "Диснейленд (Marne-la-Vallée)", originLat: 48.8703, originLon: 2.7766,
            destinationName: "Бон, старый город", destLat: 47.0235, destLon: 4.8358
        ),
        RouteLeg(
            id: 3, dateLabel: "18.09", title: "Бон → Анси", mode: .car,
            distance: "~233 км", duration: "2 ч 45 мин",
            roadNote: "A6 → A40 через Bourg-en-Bresse — не через Женеву! На навигаторе иногда предлагает маршрут через Швейцарию (нужна платная виньетка ~40 CHF).",
            warning: nil,
            originName: "Бон, старый город", originLat: 47.0235, originLon: 4.8358,
            destinationName: "Анси, старый город", destLat: 45.8992, destLon: 6.1294
        ),
        RouteLeg(
            id: 4, dateLabel: "19.09", title: "Анси → Шамони", mode: .car,
            distance: "~99 км", duration: "1 ч 20 мин",
            roadNote: "A41 → A40, горные виды в конце пути.",
            warning: nil,
            originName: "Анси, старый город", originLat: 45.8992, originLon: 6.1294,
            destinationName: "Шамони, центр", destLat: 45.9237, destLon: 6.8694
        ),
        RouteLeg(
            id: 5, dateLabel: "21.09", title: "Шамони → Ле-Зарк 1950", mode: .car,
            distance: "~120 км", duration: "2 ч",
            roadNote: "N90 через Bourg-Saint-Maurice, серпантин в конце подъёма к деревне.",
            warning: nil,
            originName: "Шамони, центр", originLat: 45.9237, originLon: 6.8694,
            destinationName: "Arc 1950, Le Village", destLat: 45.5720, destLon: 6.7930
        ),
        RouteLeg(
            id: 6, dateLabel: "24.09", title: "Ле-Зарк → Серравалле → Турин", mode: .car,
            distance: "~400 км суммарно", duration: "~5 ч за рулём + аутлет",
            roadNote: "Через перевал Col du Petit-Saint-Bernard и долину Аосты на юг к аутлету Серравалле, затем ~1 ч 10 мин обратно на север в Турин.",
            warning: "Длинный день за рулём. Выезд ранний, погоду на перевале проверьте с вечера. Если перевал закрыт — запасной путь через тоннель Фрежюс из Модана.",
            originName: "Arc 1950, Le Village", originLat: 45.5720, originLon: 6.7930,
            destinationName: "Турин, центр", destLat: 45.0685, destLon: 7.6830,
            waypoints: [
                RouteWaypoint(name: "Col du Petit-Saint-Bernard", lat: 45.6772, lon: 6.8917),
                RouteWaypoint(name: "Designer Outlet Serravalle", lat: 44.7647, lon: 8.8560),
            ]
        ),
        RouteLeg(
            id: 7, dateLabel: "26.09", title: "Турин → Лион (аэропорт)", mode: .car,
            distance: "~305 км", duration: "3 ч 30 мин",
            roadNote: "A32 → тоннель Фрежюс (~€48) → долина Морьен → A43 до аэропорта Лион-Сент-Экзюпери.",
            warning: nil,
            originName: "Турин, центр", originLat: 45.0685, originLon: 7.6830,
            destinationName: "Аэропорт Лион-Сент-Экзюпери (LYS)", destLat: 45.7256, destLon: 5.0811,
            // Через тоннель Фрежюс — иначе MKDirections может увести на объезд.
            waypoints: [
                RouteWaypoint(name: "Тоннель Фрежюс", lat: 45.1360, lon: 6.7050),
            ]
        ),
    ]
}
