
import Foundation

protocol DetailViewProtocol: class {
    func getName(name: String)
    func getUrl(url: String)
    func getFormats(formats: String)
    func getDescription(description: String)
}

protocol DetailViewPresenterProtocol: class {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, asset: Assets)
    func setAsset()
}

class DetailPresenter: DetailViewPresenterProtocol {

    weak var view: DetailViewProtocol?
    let networkService: NetworkServiceProtocol
    
    var asset: Assets
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, asset: Assets) {
        self.view = view
        self.networkService = networkService
        self.asset = asset
    }
    
    public func setAsset() {
        view?.getName(name: asset.name)
        view?.getUrl(url: asset.thumbnail.url)
        
        let formats = asset.formats.map({$0.formatType}).joined(separator: ", ")
        view?.getFormats(formats: formats)
        view?.getDescription(description: asset.description ?? "No description")
    }
}
