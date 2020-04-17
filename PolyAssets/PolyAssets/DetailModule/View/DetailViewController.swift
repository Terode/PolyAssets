
import Foundation
import UIKit

class DetailViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var assetImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var formatLabel: UILabel!
    
    //MARK: - Property
    var presenter: DetailViewPresenterProtocol!
    private let placeholderAvatar = UIImage(named: "Default avatar")
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Asset Detail"
        navigationController?.navigationBar.tintColor = UIColor.black
        presenter.setAsset()
    }
}

//MARK: - DetailViewProtocol
extension DetailViewController: DetailViewProtocol {
    func getName(name: String) {
        nameLabel.text = name
    }
    
    func getUrl(url: String) {
        assetImage.setImageLink(url, placeholder: placeholderAvatar)
    }
    
    func getDescription(description: String) {
        descriptionLabel.text = description
    }
    
    func getFormats(formats: String) {
        formatLabel.text = formats
    }
}
