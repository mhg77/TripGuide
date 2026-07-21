#!/usr/bin/env python3
"""Скачивает геометрию всех маршрутов путеводителя по реальным дорогам
(OSRM/OpenStreetMap для пеших и автомобильных, Transitous для Евростара)
и генерирует TripGuide/BundledRoutes.swift с вшитыми полилиниями.

Запуск: python3 scripts/fetch_routes.py
"""

import json
import math
import subprocess
import sys
import time

FOOT_URL = "https://routing.openstreetmap.de/routed-foot/route/v1/driving/"
CAR_URL = "https://routing.openstreetmap.de/routed-car/route/v1/driving/"
TRANSITOUS_URL = "https://api.transitous.org/api/v1/plan"

# (lat, lon) точек каждого дня в порядке плана — из TripData.swift.
DAYS = {
    1: [(51.5117, -0.1240), (51.5063, -0.1147), (51.5033, -0.1195), (51.5007, -0.1246), (51.5075, -0.1078)],
    2: [(51.5117, -0.1240), (51.5014, -0.1419), (51.5027, -0.1329), (51.4974, -0.1349), (51.4994, -0.1273), (51.5007, -0.1246), (51.5080, -0.1281), (51.5089, -0.1283)],
    3: [(51.5117, -0.1240), (51.5081, -0.0759), (51.5055, -0.0754), (51.5055, -0.0910), (51.4826, -0.0077), (51.4769, -0.0005)],
    4: [(51.5117, -0.1240), (51.6634, -0.3958), (51.6925, -0.4165)],
    5: [(51.5117, -0.1240), (51.8110, -1.6360), (51.8020, -1.6230), (51.8767, -1.7530)],
    6: [(51.5117, -0.1240), (51.5194, -0.1270), (51.5136, -0.1367), (51.5129, -0.1365), (51.5128, -0.1329)],
    7: [(51.5117, -0.1240), (51.5416, -0.1462), (51.5290, -0.1730), (51.5210, -0.1830)],
    8: [(51.5117, -0.1240), (51.5158, -0.2049), (51.5073, -0.1857), (51.5073, -0.1657)],
    9: [(48.8575, 2.3600), (48.8626, 2.2870), (48.8584, 2.2945), (48.8580, 2.3350)],
    10: [(48.8575, 2.3600), (48.8606, 2.3376), (48.8634, 2.3275), (48.8656, 2.3212), (48.8867, 2.3431), (48.8867, 2.3406), (48.8719, 2.3316), (48.8639, 2.3007)],
    11: [(48.8575, 2.3600), (48.8670, 2.7810), (48.8722, 2.7758), (48.8703, 2.7766)],
    12: [(48.8670, 2.7810), (48.8659, 2.7797)],
    13: [(48.8670, 2.7810), (51.2077, 3.2280), (51.2085, 3.2247), (51.2083, 3.2247), (51.2091, 3.2266), (51.2075, 3.2265), (51.2038, 3.2237)],
    14: [(51.2077, 3.2280), (51.1998, 3.2249), (51.1978, 3.2247), (49.2533, 4.0347), (47.0238, 4.8385), (47.0235, 4.8358), (47.0242, 4.8395)],
    15: [(47.0238, 4.8385), (47.0245, 4.8390), (45.8997, 6.1264), (45.8992, 6.1294), (45.9007, 6.1275), (45.9022, 6.1466)],
    16: [(45.8997, 6.1264), (45.8995, 6.8420), (45.9237, 6.8694), (45.9247, 6.8695), (45.8792, 6.8873)],
    17: [(45.8995, 6.8420), (45.8792, 6.8873), (45.9282, 6.8747), (45.9350, 6.8935)],
    18: [(45.8995, 6.8420), (45.6178, 6.7710), (45.5720, 6.7930)],
    19: [(45.5720, 6.7930), (45.5680, 6.7850), (45.5750, 6.7970)],
    20: [(45.5720, 6.7930), (45.6772, 6.8917), (44.7647, 8.8560), (45.5715, 6.7935)],
    21: [(45.5720, 6.7930), (45.6772, 6.8917), (45.7372, 7.3155), (45.7369, 7.3145), (45.7170, 6.9650), (45.7186, 6.9662), (45.7180, 6.9670)],
    22: [(45.7170, 6.9650), (45.7180, 6.9670), (45.7175, 6.9700)],
    23: [(45.7170, 6.9650), (45.7573, 4.8330), (45.7627, 4.8272), (45.7578, 4.8320), (45.7622, 4.8226), (45.7657, 4.8523), (45.7746, 4.8296)],
}

# Переезды из RouteData.swift: id → цепочка (lat, lon) через путевые точки.
TRANSFERS = {
    1: [(51.5308, -0.1238), (51.0854, 1.1418), (50.9268, 1.7836), (48.8809, 2.3553)],  # Евростар
    2: [(48.8703, 2.7766), (51.2085, 3.2247)],
    3: [(51.2085, 3.2247), (49.2533, 4.0347), (47.0235, 4.8358)],
    4: [(47.0235, 4.8358), (45.8992, 6.1294)],
    5: [(45.8992, 6.1294), (45.9237, 6.8694)],
    6: [(45.9237, 6.8694), (45.5720, 6.7930)],
    7: [(45.5720, 6.7930), (45.6772, 6.8917), (44.7647, 8.8560)],
    8: [(45.5720, 6.7930), (45.6772, 6.8917), (45.7186, 6.9662)],
    9: [(45.7186, 6.9662), (45.9237, 6.8694), (45.7627, 4.8272)],
}


def haversine_m(a, b):
    lat1, lon1, lat2, lon2 = map(math.radians, [a[0], a[1], b[0], b[1]])
    h = math.sin((lat2 - lat1) / 2) ** 2 + math.cos(lat1) * math.cos(lat2) * math.sin((lon2 - lon1) / 2) ** 2
    return 6371000 * 2 * math.asin(math.sqrt(h))


def fetch_json(url):
    # urllib спотыкается о сломанный системный DNS — curl резолвит надёжнее.
    out = subprocess.run(
        ["curl", "-sS", "--max-time", "30", "-A", "TripGuide route prefetch", url],
        capture_output=True, text=True, check=True,
    )
    return json.loads(out.stdout)


def downsample(coords, max_points=1500):
    """Прореживает полную геометрию: линия остаётся на дороге,
    но файл и отрисовка не раздуваются."""
    if len(coords) <= max_points:
        return coords
    step = (len(coords) - 1) / (max_points - 1)
    return [coords[round(i * step)] for i in range(max_points)]


def osrm_route(base, points):
    coords = ";".join(f"{lon},{lat}" for lat, lon in points)
    url = f"{base}{coords}?overview=full&geometries=polyline"
    # До 4 попыток с нарастающей паузой — публичный OSRM изредка троттлит.
    for attempt in range(4):
        try:
            data = fetch_json(url)
            if data.get("code") == "Ok" and data.get("routes"):
                r = data["routes"][0]
                decoded = downsample(decode_polyline(r["geometry"], 5))
                return encode_polyline(decoded, 5), r["duration"], r["distance"]
            if data.get("code") in ("NoRoute", "NoSegment"):
                return None  # дороги действительно нет — повторять бессмысленно
        except Exception as e:
            print(f"  попытка {attempt + 1} упала: {e}", file=sys.stderr)
        time.sleep(2 * (attempt + 1))
    return None


def decode_polyline(encoded, precision):
    factor = 10 ** precision
    coords, lat, lon, i = [], 0, 0, 0
    while i < len(encoded):
        for is_lon in (False, True):
            shift = result = 0
            while True:
                b = ord(encoded[i]) - 63
                i += 1
                result |= (b & 0x1F) << shift
                shift += 5
                if b < 0x20:
                    break
            delta = ~(result >> 1) if result & 1 else result >> 1
            if is_lon:
                lon += delta
            else:
                lat += delta
        coords.append((lat / factor, lon / factor))
    return coords


def encode_polyline(coords, precision):
    factor = 10 ** precision
    out, prev_lat, prev_lon = [], 0, 0
    for lat, lon in coords:
        ilat, ilon = round(lat * factor), round(lon * factor)
        for delta in (ilat - prev_lat, ilon - prev_lon):
            v = ~(delta << 1) if delta < 0 else delta << 1
            while v >= 0x20:
                out.append(chr((0x20 | (v & 0x1F)) + 63))
                v >>= 5
            out.append(chr(v + 63))
        prev_lat, prev_lon = ilat, ilon
    return "".join(out)


def transitous_rail(points):
    """Полная геометрия поездки на поезде из Transitous: все сегменты маршрута
    (Евростар + пересадка, если есть) склеены в одну линию precision 7."""
    frm, to = points[0], points[-1]
    url = f"{TRANSITOUS_URL}?fromPlace={frm[0]},{frm[1]}&toPlace={to[0]},{to[1]}&numItineraries=1"
    try:
        data = fetch_json(url)
        itin = data["itineraries"][0]
        merged = []
        for leg in itin["legs"]:
            geometry = leg["legGeometry"]
            merged.extend(decode_polyline(geometry["points"], geometry.get("precision", 7)))
        if len(merged) < 2:
            return None
        return encode_polyline(merged, 7), itin["duration"], haversine_m(frm, to)
    except Exception as e:
        print(f"  transitous fail: {e}", file=sys.stderr)
        return None


def swift_escape(s):
    return s.replace("\\", "\\\\").replace('"', '\\"')


def main():
    entries = []   # (key, polyline, precision, duration, distance, is_walk)
    failures = []

    for day_id, pois in sorted(DAYS.items()):
        for i in range(1, len(pois)):
            a, b = pois[i - 1], pois[i]
            dist = haversine_m(a, b)
            is_walk = dist <= 5000
            base = FOOT_URL if is_walk else CAR_URL
            key = f"d{day_id}-{i}"
            try:
                result = osrm_route(base, [a, b])
            except Exception as e:
                print(f"  {key}: запрос упал ({e})", file=sys.stderr)
                result = None
            if result:
                geometry, duration, distance = result
                entries.append((key, geometry, 5, duration, distance, is_walk))
                print(f"{key}: OK {'пешком' if is_walk else 'авто'} {int(distance)}м")
            else:
                failures.append(key)
                print(f"{key}: НЕТ МАРШРУТА (пропущен)")
            time.sleep(0.15)

    for t_id, pts in sorted(TRANSFERS.items()):
        key = f"t{t_id}"
        if t_id == 1:
            rail = transitous_rail(pts)
            if rail:
                geometry, duration, distance = rail
                entries.append((key, geometry, 7, duration, distance, False))
                print(f"{key}: OK Евростар (Transitous, ж/д геометрия)")
                time.sleep(0.15)
                continue
            print(f"{key}: Transitous не ответил — беру автодорогу через Евротоннель")
        try:
            result = osrm_route(CAR_URL, pts)
        except Exception as e:
            print(f"  {key}: запрос упал ({e})", file=sys.stderr)
            result = None
        if result:
            geometry, duration, distance = result
            entries.append((key, geometry, 5, duration, distance, False))
            print(f"{key}: OK авто {int(distance / 1000)}км")
        else:
            failures.append(key)
            print(f"{key}: НЕТ МАРШРУТА (пропущен)")
        time.sleep(0.15)

    lines = []
    lines.append("import Foundation")
    lines.append("")
    lines.append("// Автосгенерировано scripts/fetch_routes.py — НЕ редактировать вручную.")
    lines.append("// Офлайн-геометрия всех маршрутов по реальным дорогам (OSRM/OpenStreetMap,")
    lines.append("// для Евростара — ж/д линия из Transitous). Приложение показывает эти линии")
    lines.append("// мгновенно и без сети; живые сервисы лишь уточняют картинку, когда доступны.")
    lines.append("nonisolated enum BundledRoutes {")
    lines.append("")
    lines.append("    nonisolated struct Entry {")
    lines.append("        let polyline: String       // полилиния в кодировке Google")
    lines.append("        let precision: Int         // 5 — OSRM, 7 — Transitous")
    lines.append("        let durationSeconds: Double")
    lines.append("        let distanceMeters: Double")
    lines.append("        let isWalk: Bool")
    lines.append("    }")
    lines.append("")
    lines.append("    /// \"d<день>-<индекс>\" — от pois[индекс-1] к pois[индекс]; \"t<id>\" — переезд.")
    lines.append("    static let entries: [String: Entry] = [")
    for key, geometry, precision, duration, distance, is_walk in entries:
        walk = "true" if is_walk else "false"
        lines.append(
            f'        "{key}": Entry(polyline: "{swift_escape(geometry)}", '
            f"precision: {precision}, durationSeconds: {duration:.0f}, "
            f"distanceMeters: {distance:.0f}, isWalk: {walk}),"
        )
    lines.append("    ]")
    lines.append("")
    lines.append("    static func entry(day: Int, poiIndex: Int) -> Entry? {")
    lines.append('        entries["d\\(day)-\\(poiIndex)"]')
    lines.append("    }")
    lines.append("")
    lines.append("    static func entry(transfer id: Int) -> Entry? {")
    lines.append('        entries["t\\(id)"]')
    lines.append("    }")
    lines.append("}")

    out_path = "TripGuide/BundledRoutes.swift"
    with open(out_path, "w") as f:
        f.write("\n".join(lines) + "\n")
    print(f"\nЗаписано {len(entries)} маршрутов в {out_path}")
    if failures:
        print(f"Без геометрии (канатки и т.п. — нет дороги): {', '.join(failures)}")


if __name__ == "__main__":
    main()
