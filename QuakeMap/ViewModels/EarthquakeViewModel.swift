import Foundation
import Observation

@Observable
final class EarthquakeViewModel {
    var quakes: [EarthquakeFeature] = []
    var isLoading = false
    var range: FeedRange = .day
    var minMagnitude: Double = 2.5
    var errorMessage: String?

    private let service = USGSService()

    var filtered: [EarthquakeFeature] {
        quakes.filter { $0.magnitude >= minMagnitude }
    }

    func load() async {
        isLoading = true
        errorMessage = nil
        do {
            quakes = try await service.fetch(range: range)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
