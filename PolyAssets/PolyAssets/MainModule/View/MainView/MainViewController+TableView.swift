
import Foundation
import UIKit

//MARK: UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.poly?.assets.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: AssetCell = tableView.reusableCell(for: indexPath)
        
        if let asset = presenter.poly?.assets.getElement(at: indexPath.row) {
            cell.nameLabel.text = asset.name
            cell.descriptionLabel.text = asset.description ?? "No description"
        }
        
        return cell
    }
}

//MARK: UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let asset = presenter.poly?.assets.getElement(at: indexPath.row) {
            let detailViewController = ModuleBuilder.createDetailPresenter(asset: asset)
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

