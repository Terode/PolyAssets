
import UIKit

extension UITableView {
    func register(_ cellType: UITableViewCell.Type, bundle: Bundle? = nil) {
        let nibName = String(describing: cellType.self)
        let nib = UINib(nibName: nibName, bundle: bundle)
        self.register(nib, forCellReuseIdentifier: nibName)
    }
    
    /// Returns a reusable table-view cell object for the type reuse identifier and adds it to the table.
    ///
    /// - Parameter indexPath: The index path specifying the location of the cell.
    /// - Returns: A UITableViewCell object with the associated reuse identifier.
    func reusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let id = String(describing: T.self)
        return self.dequeueReusableCell(withIdentifier: id, for: indexPath) as! T
    }
}
