import Foundation
import UIKit

struct ServerData: Decodable {
    let results: [Character]?
}

struct Character: Decodable {
    let name: String?
    let gender: String?
    let species: String?
    let location: Location?
    let image: String?
}

struct Location: Decodable {
    let name: String?
    let url: String?
}
