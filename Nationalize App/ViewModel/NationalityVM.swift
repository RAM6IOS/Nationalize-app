
import Foundation

class NationalityVM: ObservableObject {
    @Published var nationality: Nationality?
    func fetch(name: String) {
        guard let url = URL(string: "https://api.nationalize.io?name=\(name)") else {
            return print("API Error")
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self]
            data, _, error in
            guard let data = data, error == nil else { return  }
            
            do {
                let nationality = try
                JSONDecoder().decode(Nationality.self, from: data)
                DispatchQueue.main.async {
                    self?.nationality = nationality
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
