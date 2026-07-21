import Testing
import Foundation
import CoreLocation
import UIKit
@testable import TripGuide

// Проверки целостности рукописных данных путеводителя — ловят опечатки и
// рассинхронизацию между TripData, BookingData, RouteData и каталогом ассетов.

struct TripDataTests {

    @Test func tripHas23SequentialDays() {
        #expect(TripData.allDays.count == 23)
        for (index, day) in TripData.allDays.enumerated() {
            #expect(day.id == index + 1, "id дней должны идти подряд с 1")
            #expect(day.day == index + 5, "числа месяца должны идти подряд с 5 сентября")
        }
    }

    @Test func everyTripDateResolvesToDay() {
        let calendar = Calendar.current
        for dayOfMonth in 5...27 {
            let date = calendar.date(from: DateComponents(year: 2026, month: 9, day: dayOfMonth))!
            let day = TripData.day(for: date)
            #expect(day?.day == dayOfMonth)
        }
        // За границами окна поездки — nil.
        let before = calendar.date(from: DateComponents(year: 2026, month: 9, day: 4))!
        let after = calendar.date(from: DateComponents(year: 2026, month: 9, day: 28))!
        let otherYear = calendar.date(from: DateComponents(year: 2025, month: 9, day: 10))!
        #expect(TripData.day(for: before) == nil)
        #expect(TripData.day(for: after) == nil)
        #expect(TripData.day(for: otherYear) == nil)
    }

    @Test func everyDayHasDistinctRainObject() {
        let objects = TripData.allDays.compactMap { RainObject.forDay(id: $0.id) }
        #expect(objects.count == TripData.allDays.count, "у каждого дня должна быть пасхалка")
        #expect(Set(objects).count == objects.count, "предметы пасхалок не должны повторяться")
    }

    @Test func rainObjectSpritesExistInAssets() {
        for object in RainObject.allCases {
            #expect(UIImage(named: object.imageName) != nil, "нет ассета \(object.imageName)")
        }
    }

    @Test func nightPhotosExistForEveryCity() {
        for city in City.allCases {
            #expect(UIImage(named: city.nightImageName) != nil, "нет ассета \(city.nightImageName)")
        }
        #expect(UIImage(named: "NightOverview") != nil, "нет обзорного фона календаря")
    }

    @Test func poiCoordinatesAreWithinRouteRegion() {
        // Маршрут целиком лежит между Котсуолдсом и Серравалле —
        // координата за этими рамками почти наверняка опечатка.
        for day in TripData.allDays {
            for poi in day.pois {
                #expect((43.0...53.0).contains(poi.latitude), "широта: \(poi.name)")
                #expect((-3.0...10.0).contains(poi.longitude), "долгота: \(poi.name)")
            }
        }
    }

    @Test func everyDayHasBlocksAndPOIs() {
        for day in TripData.allDays {
            #expect(!day.blocks.isEmpty, "день \(day.id) без плана")
            #expect(!day.pois.isEmpty, "день \(day.id) без точек на карте")
        }
    }

    @Test func everyDayHasStartPoint() {
        // От стартовой точки во вкладке "Карта" строятся маршруты до выбранных мест:
        // отель, где ночуем, либо (в финальный день без ночёвки) паркинг первой точкой.
        for day in TripData.allDays {
            let hasHotel = day.pois.contains { $0.category == .hotel }
            let startsWithTransfer = day.pois.first?.category == .transfer
            #expect(hasHotel || startsWithTransfer, "день \(day.id) без стартовой точки")
        }
    }
}

struct BookingDataTests {

    @Test func bookingDaysExistInTrip() {
        let dayIDs = Set(TripData.allDays.map(\.id))
        for dayID in BookingData.items.keys {
            #expect(dayIDs.contains(dayID), "брони привязаны к несуществующему дню \(dayID)")
        }
    }

    @Test func bookingURLsAreValid() {
        for items in BookingData.items.values {
            for item in items {
                if item.officialURLString != nil {
                    #expect(item.officialURL != nil, "битая официальная ссылка: \(item.name)")
                    #expect(item.officialURL?.scheme == "https", "не-https ссылка: \(item.name)")
                }
                #expect(item.mapsURL != nil, "не собралась ссылка на карту: \(item.name)")
                if item.bookingComQuery != nil {
                    #expect(item.bookingComURL != nil, "не собралась ссылка Booking.com: \(item.name)")
                }
            }
        }
    }

    @Test func bookingNamesAreUniquePerDay() {
        // Название вместе с id дня — ключ отметки "забронировано";
        // дубликат означал бы, что две карточки делят одну отметку.
        for (dayID, items) in BookingData.items {
            let names = items.map(\.name)
            #expect(Set(names).count == names.count, "дубликат названия брони в дне \(dayID)")
        }
    }
}

struct TransitRoutingTests {

    @Test func polylineDecoderMatchesReference() {
        // Реальный фрагмент ответа Transitous (пеший сегмент у Gare du Nord, precision 7).
        // Эталонные значения посчитаны независимым декодером.
        let decoded = TransitRouting.decodePolyline("{~pic\\gfq|k@j\\vG", precision: 7)
        #expect(decoded.count == 2)
        if decoded.count == 2 {
            #expect(abs(decoded[0].latitude - 48.880947) < 0.000001)
            #expect(abs(decoded[0].longitude - 2.355314) < 0.000001)
            #expect(abs(decoded[1].latitude - 48.8809) < 0.000001)
            #expect(abs(decoded[1].longitude - 2.3553) < 0.000001)
        }
    }

    @Test func polylineDecoderHandlesEmptyString() {
        #expect(TransitRouting.decodePolyline("", precision: 7).isEmpty)
    }
}

struct BundledRoutesTests {

    @Test func everyDayPairHasBundledGeometry() {
        // Каждая пара соседних точек дня должна иметь вшитый маршрут, а его концы —
        // сходиться с координатами точек. Это ловит рассинхронизацию рукописного
        // TripData.swift и координат в scripts/fetch_routes.py (маршруты качает он).
        // Исключение: вершина Aiguille du Midi — дороги туда нет, линия ведёт к канатке.
        let noRoadKeys: Set<String> = ["d17-1"]
        for day in TripData.allDays {
            for index in 1..<day.pois.count {
                let key = "d\(day.id)-\(index)"
                guard let entry = BundledRoutes.entry(day: day.id, poiIndex: index) else {
                    Issue.record("нет вшитого маршрута \(key)")
                    continue
                }
                let coords = TransitRouting.decodePolyline(entry.polyline, precision: entry.precision)
                #expect(coords.count >= 2, "маршрут \(key) не декодируется")
                guard let first = coords.first, let last = coords.last, !noRoadKeys.contains(key) else { continue }
                let origin = day.pois[index - 1], destination = day.pois[index]
                let startGap = CLLocation(latitude: first.latitude, longitude: first.longitude)
                    .distance(from: CLLocation(latitude: origin.latitude, longitude: origin.longitude))
                let endGap = CLLocation(latitude: last.latitude, longitude: last.longitude)
                    .distance(from: CLLocation(latitude: destination.latitude, longitude: destination.longitude))
                #expect(startGap < 700, "\(key): старт в \(Int(startGap)) м от «\(origin.name)»")
                #expect(endGap < 700, "\(key): финиш в \(Int(endGap)) м от «\(destination.name)»")
            }
        }
    }

    @Test func everyTransferHasBundledGeometry() {
        for route in RouteData.allRoutes {
            let entry = BundledRoutes.entry(transfer: route.id)
            #expect(entry != nil, "нет вшитого маршрута переезда t\(route.id)")
            guard let entry else { continue }
            let coords = TransitRouting.decodePolyline(entry.polyline, precision: entry.precision)
            #expect(coords.count >= 2, "переезд t\(route.id) не декодируется")
            // Геометрия должна начинаться и заканчиваться рядом с точками переезда.
            if let first = coords.first, let last = coords.last {
                let startGap = CLLocation(latitude: first.latitude, longitude: first.longitude)
                    .distance(from: CLLocation(latitude: route.originLat, longitude: route.originLon))
                let endGap = CLLocation(latitude: last.latitude, longitude: last.longitude)
                    .distance(from: CLLocation(latitude: route.destLat, longitude: route.destLon))
                #expect(startGap < 2000, "старт t\(route.id) далеко от начала переезда")
                #expect(endGap < 2000, "финиш t\(route.id) далеко от конца переезда")
            }
        }
    }
}

struct RouteDataTests {

    @Test func routesHaveUniqueIDs() {
        let ids = RouteData.allRoutes.map(\.id)
        #expect(Set(ids).count == ids.count)
    }

    @Test func routeCoordinatesAndLinksAreValid() {
        for route in RouteData.allRoutes {
            for coordinate in [route.originCoordinate, route.destinationCoordinate] {
                #expect((43.0...53.0).contains(coordinate.latitude), "широта: \(route.title)")
                #expect((-3.0...10.0).contains(coordinate.longitude), "долгота: \(route.title)")
            }
            #expect(route.googleMapsURL != nil, "не собралась ссылка навигации: \(route.title)")
        }
    }
}
