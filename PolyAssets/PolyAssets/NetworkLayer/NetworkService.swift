
import Foundation
import Alamofire
import KRProgressHUD

protocol NetworkServiceProtocol {
    func getListAssert(pageToken: String?,
                       perPage: Int,
                       loader: Bool,
                       success: @escaping (Poly) -> (),
                       failure: @escaping (Error)->())
}

class NetworkService: RestCalls, NetworkServiceProtocol {
    func getListAssert(pageToken: String? = nil,
                       perPage: Int = 20,
                       loader: Bool = true,
                       success: @escaping (Poly) -> (),
                       failure: @escaping (Error)->()) {
        
        if loader {
            KRProgressHUD.show()
        }
        
        let urlComponents: URLComponents? = {
            var components = URLComponents(string: RestSuffix.Assets.getList().getURL())
            components?.queryItems = []
            
            if let keys = getKeys() {
                components?.queryItems?.append(keys)
            }
            
            if let pageToken = pageToken {
                components?.queryItems?.append((URLQueryItem(name: "pageToken", value: "\(pageToken)")))
            }
            
            return components
        }()
        
        guard let path = urlComponents?.string else {
            debugPrint(#function)
            return
        }
        
        self.call(model: Poly.self, path: path, method: .get, name: RestSuffix.Assets.getList(), success: { (model) in
            success(model)
            KRProgressHUD.dismiss()
        }, error: { (error) in
            failure(error)
            KRProgressHUD.dismiss()
        }) { (error) in
            failure(error)
            KRProgressHUD.dismiss()
        }
    }
}
