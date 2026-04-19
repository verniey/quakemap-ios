# QuakeMap

Live map of global earthquakes from the last hour / 24 hours / 7 days, built with SwiftUI and MapKit.

Data source: [USGS Earthquake Hazards Program](https://earthquake.usgs.gov/earthquakes/feed/v1.0/) — public domain.

## Features

- Real-time map of earthquakes worldwide
- Color-coded magnitude badges (green → red)
- Tap any quake for depth, exact coordinates, and USGS link
- Filter by time range and minimum magnitude
- Pull-to-refresh

## Stack

- SwiftUI (iOS 17+)
- MapKit (`Map` with `MapContentBuilder`)
- `URLSession` + `async/await` + `Codable`
- `@Observable` for state management

## Architecture

```
Models/         Earthquake.swift         — Codable GeoJSON models
Services/       USGSService.swift        — network layer
ViewModels/     EarthquakeViewModel.swift — @Observable state
Views/          EarthquakeMapView.swift   — map screen
                EarthquakeDetailView.swift — sheet with details
                MagnitudeBadge.swift      — reusable annotation view
```

## Data

Credit: U.S. Geological Survey / Department of the Interior / USGS

USGS-authored data is in the U.S. Public Domain and can be freely used:
https://www.usgs.gov/information-policies-and-instructions/copyrights-and-credits
