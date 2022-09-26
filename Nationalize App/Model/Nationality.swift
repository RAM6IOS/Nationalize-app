
import Foundation
struct Nationality: Codable {
    let country: [Country]
    let name: String
}
struct Country: Codable {
    let countryID: String
    let probability: Double
    
    enum CodingKeys: String, CodingKey {
        case countryID = "country_id"
        case probability
    }
}
