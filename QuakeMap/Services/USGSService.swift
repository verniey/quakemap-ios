import Foundation

enum FeedRange: String, CaseIterable, Identifiable {
    case hour = "all_hour"
    case day = "all_day"
    case week = "all_week"

    var id: String { rawValue }
    var title: String {
        switch self {
        case .hour: return "Last Hour"
        case .day: return "Last 24 Hours"
        case .week: return "Last 7 Days"
        }
    }
}

struct USGSService {
    func fetch(range: FeedRange) async throws -> [EarthquakeFeature] {
        let url = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/\(range.rawValue).geojson")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let feed = try JSONDecoder().decode(EarthquakeFeed.self, from: data)
        return feed.features
    }
}
