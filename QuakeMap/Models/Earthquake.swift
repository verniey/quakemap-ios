import Foundation
import CoreLocation

struct EarthquakeFeed: Decodable {
    let features: [EarthquakeFeature]
}

struct EarthquakeFeature: Decodable, Identifiable {
    let id: String
    let properties: Properties
    let geometry: Geometry

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: geometry.latitude, longitude: geometry.longitude)
    }
    var magnitude: Double { properties.mag ?? 0 }
    var place: String { properties.place ?? "Unknown location" }
    var date: Date { Date(timeIntervalSince1970: properties.time / 1000) }
    var depth: Double { geometry.depth }

    struct Properties: Decodable {
        let mag: Double?
        let place: String?
        let time: Double
        let url: String?
        let title: String?
    }

    struct Geometry: Decodable {
        let coordinates: [Double]
        var longitude: Double { coordinates[0] }
        var latitude: Double { coordinates[1] }
        var depth: Double { coordinates.count > 2 ? coordinates[2] : 0 }
    }
}
