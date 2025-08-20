import Foundation

struct Death: Decodable {
    let character: String
    let image: URL
    let details: String
    let lastWords: String
    let responsible: [String]
    let episode: Int
}
