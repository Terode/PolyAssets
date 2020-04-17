
import Foundation

typealias Suffix = String

struct RestSuffix {
    
    ///-------------------------------------------------------------------------------------------------------------------------
    struct Assets {
        /// get list assets
        static func getList() -> Suffix {
            return "assets"
        }
    }
}

//MARK: - Suffix URL
extension Suffix {

    func getBaseUrl() -> String {
        let apiURL = KeysService.Key.apiURL + KeysService.Key.APIVersion
        return apiURL
    }

    func getURL(params: String? = nil, isEncoding: Bool = true) -> String {

        var path = getBaseUrl() + self

        if let params = params {
            path += params
        }

        return isEncoding ? path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)! : path
    }

    func getURL(queryItems: [String : String], isEncoding: Bool = true) -> String {

        let path = getBaseUrl() + self

        guard var components = URLComponents(string: path) else {
            fatalError("RestSuffix: Can't create URLComponents with: \(path)")
        }

        components.queryItems = queryItems.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }

        guard let link = components.string else {
            fatalError("RestSuffix: Can't create components.string: \(path)")
        }

        return isEncoding ? link.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)! : link
    }
}
