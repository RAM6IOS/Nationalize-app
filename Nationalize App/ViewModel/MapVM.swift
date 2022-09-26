import Foundation
import MapKit

class MapVM: ObservableObject {
    @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.864716, longitude: 2.349014), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))

    @Published var dataSet: DataSet?
    func fetch(countryName: String) {
        guard let url = URL(string: "https://public.opendatasoft.com/api/records/1.0/search/?dataset=countries-codes&q=\(countryName)") else {
            return print("API Error")
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return  }


            do {
                let dataSet = try JSONDecoder().decode(DataSet.self, from: data)
                print("dataSet: \(dataSet)")
                DispatchQueue.main.async {
                    self?.dataSet = dataSet
                    self?.mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: dataSet.records[0].geometry.coordinates[1],
                    longitude: dataSet.records[0].geometry.coordinates[0]),
                    span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20))
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

