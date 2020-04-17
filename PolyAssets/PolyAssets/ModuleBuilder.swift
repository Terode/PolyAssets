
import Foundation
import UIKit

protocol Builder {
    static func createMainPresenter() -> UIViewController
    static func createDetailPresenter(asset: Assets) -> UIViewController
}

class ModuleBuilder: Builder {
    static func createMainPresenter() -> UIViewController {
        let view = MainViewController()
        let network = NetworkService()
        let presenter = MainPresenter(view: view, networkService: network)
        view.presenter = presenter
        
        return view
    }
    
    static func createDetailPresenter(asset: Assets) -> UIViewController {
        let view = DetailViewController()
        let network = NetworkService()
        let presenter = DetailPresenter(view: view, networkService: network, asset: asset)
        view.presenter = presenter
        
        return view
    }
}
