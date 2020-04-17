
import UIKit

class MainViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Property
    var presenter: MainViewPresenterProtocol!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Setup
    private func setup() {
        self.title = "Assets"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(AssetCell.self)
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        tableView.addFooter(withTarget: self, action: #selector(footerRefresh(sender:)))
    }
    
    //MARK: - Actions
    @objc private func footerRefresh(sender:AnyObject) {
        presenter.loadMore()
    }
}

//MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    func success() {
        tableView.reloadData()
    }
    
    func successLoadMore() {
        tableView.footerEndRefreshing()
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        debugPrint(#function)
        tableView.footerEndRefreshing()
    }
}
