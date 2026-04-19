import SwiftUI
import CoreLocation

struct EarthquakeDetailView: View {
    let quake: EarthquakeFeature

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    MagnitudeBadge(magnitude: quake.magnitude)
                        .scaleEffect(1.6)
                        .padding(.trailing, 8)
                    VStack(alignment: .leading) {
                        Text(String(format: "Magnitude %.1f", quake.magnitude))
                            .font(.title2.bold())
                        Text(quake.place)
                            .foregroundStyle(.secondary)
                    }
                }

                Divider()

                Label(quake.date.formatted(date: .abbreviated, time: .shortened),
                      systemImage: "clock")
                Label(String(format: "Depth: %.1f km", quake.depth),
                      systemImage: "arrow.down.to.line")
                Label(String(format: "%.4f°, %.4f°",
                             quake.coordinate.latitude,
                             quake.coordinate.longitude),
                      systemImage: "location")

                if let urlStr = quake.properties.url, let url = URL(string: urlStr) {
                    Link(destination: url) {
                        Label("Open on USGS", systemImage: "arrow.up.right.square")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top)
                }
            }
            .padding()
        }
    }
}
