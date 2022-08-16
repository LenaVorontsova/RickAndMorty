import Foundation
import UIKit

struct ServerDataLocation: Decodable {
    let results: [LocationInfo]?
}

struct LocationInfo: Decodable {
    let name: String?
    let type: String?
    let dimension: String?
}

