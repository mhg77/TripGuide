# TripGuide — London → Lyon 🗺️

A SwiftUI travel guide app: 23 days along the route London → Brussels → Bruges → Beaune → Annecy → Arcs 1950 → Val d'Isère → Lyon, September 2026.

## Screenshots

| | | |
|---|---|---|
| ![Calendar](docs/screenshots/01_calendar.png) | ![Routes](docs/screenshots/02_routes.png) | ![Route detail](docs/screenshots/03_route_detail.png) |
| Main screen — 23 days | Routes tab | Transfer detail map |
| ![Day plan](docs/screenshots/04_day_plan.png) | ![Day map](docs/screenshots/05_day_map.png) | ![Bookings](docs/screenshots/06_bookings.png) |
| Day plan with stops | Day map with POIs | Bookings & tickets |

## Features

- **23-day calendar** — tap any day to open its plan, map, and bookings
- **In-day map** — routes between stops along real roads (offline, geometry bundled in the app)
- **99 offline routes** — walking, driving, and Eurostar through the Channel Tunnel
- **Routes tab** — all transfers with map and "Open in Google Maps" button
- **Info tab** — documents, money, weather, budget, and backup plans
- **Bookings & tickets** — all hotels, transport, and attractions with dates
- **Swipe between days** — left/right without going back to the calendar
- **Easter eggs** — triple-tap on a day's plan screen triggers a unique animation for each of the 23 days
- **iPad support** — comfortable column width, larger map

## Tech Stack

| | |
|---|---|
| UI | SwiftUI (iOS 17+) |
| Maps | MapKit, `MKDirections` |
| Offline routes | OSRM (roads), Transitous / GTFS (Eurostar) |
| Geometry | Google Encoded Polyline (99 routes in `BundledRoutes.swift`) |
| Tests | Swift Testing framework (17 tests) |
| Language | Swift 6 |

## Project Structure

```
TripGuide/
├── TripGuideApp.swift       # App entry point
├── RootView.swift           # Bottom tab bar
├── Theme.swift              # Colors, fonts, and helper modifiers
├── Models.swift             # Day and POI data models
├── TripData.swift           # All 23 days: stops, descriptions, coordinates
├── CalendarView.swift       # Main calendar screen
├── DayDetailView.swift      # Day screen (plan / map / bookings)
├── DayPlanView.swift        # Day stop list with easter egg
├── MapTabView.swift         # Day map with route polyline
├── MapGeometry.swift        # Shared helper: camera fit, region
├── RouteModels.swift        # Transfer and waypoint models
├── RouteData.swift          # All 9 transfers with waypoints
├── RoutesView.swift         # Transfer list
├── RouteDetailView.swift    # Transfer detail map
├── TransitRouting.swift     # Transitous API client
├── BundledRoutes.swift      # 99 offline routes (auto-generated)
├── BookingModels.swift      # Booking data models
├── BookingData.swift        # Bookings and ticket data
├── BookingsTabView.swift    # Bookings screen
├── InfoView.swift           # Reference section
├── NightCityScene.swift     # Animated night city background per city
├── EasterEggScene.swift     # Per-day easter eggs
├── Haptics.swift            # Haptic feedback
└── Assets.xcassets/         # App icon, colors, city photos
```

## Offline Routes

All 99 routes are pre-fetched and bundled in `BundledRoutes.swift` — the app renders real road geometry with no network required. To refresh routes:

```bash
cd scripts
python3 fetch_routes.py
```

The script queries OSRM (driving and walking routes) and Transitous (Eurostar rail geometry) and overwrites `BundledRoutes.swift`.

## Tests

```bash
# In Xcode: Product → Test (⌘U)
```

17 tests covering data integrity for all 23 days, offline geometry presence for all 99 routes, and coordinate accuracy.
