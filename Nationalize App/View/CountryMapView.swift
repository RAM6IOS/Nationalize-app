
import SwiftUI
import MapKit

struct CountryMapView: View {
    @StateObject var mapViewModel = MapVM()
        let countryName: String
    var body: some View {
        NavigationView {
                    VStack{
                        Map(coordinateRegion: $mapViewModel.mapRegion)
                            .navigationTitle(mapViewModel.dataSet?.records[0].fields.labelEn ?? "")
                    }
                }
                .onAppear {
                    print(countryName)
                    mapViewModel.fetch(countryName: countryName)
                }
    }
}

