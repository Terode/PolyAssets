
import Foundation

//MARK: - Output
protocol MainViewProtocol: class {
    func success()
    func successLoadMore()
    func failure(error: Error)
}

//MARK: - Input
protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
    
    func getPolys()
    func loadMore()
    
    var poly: Poly? { set get }
}

class MainPresenter: MainViewPresenterProtocol {
    private weak var view: MainViewProtocol?
    private let networkService: NetworkServiceProtocol
    
    var poly: Poly?
    
    //MARK: - Init
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getPolys()
    }
    
    //MARK: - Loading
    func getPolys() {
        NetworkService().getListAssert(success: { [weak self] (models) in
            self?.poly = models
            self?.view?.success()
        }) { [weak self] (error) in
            self?.view?.failure(error: error)
        }
    }
    
    func loadMore() {
        if let nextPage = poly?.nextPageToken, poly?.totalSize ?? 0 > 0 {
            NetworkService().getListAssert(pageToken: nextPage, success: { [weak self] (models) in
                guard let `self` = self else { return }
                self.poly?.assets += models.assets
                self.poly?.totalSize = models.totalSize
                self.poly?.nextPageToken = models.nextPageToken
                self.view?.successLoadMore()
            }) { [weak self] (error) in
                self?.view?.failure(error: error)
            }
        }
    }
}
