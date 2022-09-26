
import Foundation

struct DataSet: Codable {
        let nhits: Int
        let parameters: Parameters
        let records: [Record]
    }

    struct Parameters: Codable {
        let dataset, q: String
        let rows, start: Int
        let format, timezone: String
    }

    struct Record: Codable {
        let datasetid, recordid: String
        let fields: Fields
        let geometry: Geometry
        let recordTimestamp: String

        enum CodingKeys: String, CodingKey {
            case datasetid, recordid, fields, geometry
            case recordTimestamp = "record_timestamp"
        }
    }

    struct Fields: Codable {
        let labelSP, onuCode, isIlomember: String
        let geoPoint2D: [Double]
        let iso2Code, iso3Code, labelFr, officialLangCode: String
        let labelEn, isReceivingQuest: String
        let geoShape: GeoShape

        enum CodingKeys: String, CodingKey {
            case labelSP = "label_sp"
            case onuCode = "onu_code"
            case isIlomember = "is_ilomember"
            case geoPoint2D = "geo_point_2d"
            case iso2Code = "iso2_code"
            case iso3Code = "iso3_code"
            case labelFr = "label_fr"
            case officialLangCode = "official_lang_code"
            case labelEn = "label_en"
            case isReceivingQuest = "is_receiving_quest"
            case geoShape = "geo_shape"
        }
    }

    struct GeoShape: Codable {
        let coordinates: [[[Double]]]
        let type: String
    }

    struct Geometry: Codable {
        let type: String
        let coordinates: [Double]
    }

