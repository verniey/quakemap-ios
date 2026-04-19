import SwiftUI
import MapKit

struct EarthquakeMapView: View {
    @State private var viewModel = EarthquakeViewModel()
    @State private var selectedID: String?
    @State private var position: MapCameraPosition = .automatic

    private var selected: EarthquakeFeature? {
        viewModel.filtered.first { $0.id == selectedID }
    }

    var body: some View {
        NavigationStack {
            Map(position: $position, selection: $selectedID) {
                ForEach(viewModel.filtered) { quake in
                    Annotation(quake.place, coordinate: quake.coordinate) {
                        MagnitudeBadge(magnitude: quake.magnitude)
                    }
                    .tag(quake.id)
                }
            }
            .mapStyle(.standard(elevation: .realistic))
            .overlay(alignment: .top) {
                if viewModel.isLoading {
                    ProgressView()
                        .padding(8)
                        .background(.regularMaterial, in: Capsule())
                        .padding(.top)
                }
            }
            .overlay(alignment: .bottom) {
                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.caption)
                        .padding(8)
                        .background(.red.opacity(0.2), in: RoundedRectangle(cornerRadius: 8))
                        .padding()
                }
            }
            .navigationTitle("Earthquakes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    filterMenu
                }
            }
            .onChange(of: viewModel.range) { _, _ in
                Task { await viewModel.load() }
            }
            .task { await viewModel.load() }
            .refreshable { await viewModel.load() }
            .sheet(item: Binding(
                get: { selected },
                set: { selectedID = $0?.id }
            )) { quake in
                EarthquakeDetailView(quake: quake)
                    .presentationDetents([.medium, .large])
            }
        }
    }

    private var filterMenu: some View {
        Menu {
            Picker("Range", selection: $viewModel.range) {
                ForEach(FeedRange.allCases) { range in
                    Text(range.title).tag(range)
                }
            }
            Section("Min magnitude: \(viewModel.minMagnitude, specifier: "%.1f")") {
                Slider(value: $viewModel.minMagnitude, in: 0...7, step: 0.5)
            }
        } label: {
            Image(systemName: "line.3.horizontal.decrease.circle")
        }
    }
}
