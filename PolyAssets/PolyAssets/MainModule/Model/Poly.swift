
import Foundation

struct Poly: Codable {
    var assets: [Assets]
    var totalSize: Int
    var nextPageToken: String
}

struct Assets: Codable {
    let authorName: String?
    let createTime: String
    let description: String?
    let displayName: String
    let name: String
    let thumbnail: ThumbnailAsset
    let formats: [FormatsAsset]
}

struct ThumbnailAsset: Codable {
    let contentType: String
    let relativePath: String
    let url: String
}

struct FormatsAsset: Codable {
    let formatType: String
}
