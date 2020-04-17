
import Foundation
import Kingfisher

extension UIImageView {
    func setImageURL(_ url: URL?, placeholder: UIImage? = nil, isCustomIndicator:Bool = false, completion: ((UIImage?, NSError?) -> Void)? = nil) {
        if isCustomIndicator {
            self.kf.indicatorType = .custom(indicator: CustomIndicatorKF())
        } else {
            self.kf.indicatorType = .activity
        }
        
        self.kf.setImage(with: url, placeholder: placeholder, completionHandler: { (image, error, _, _) in
            completion?(image, error)
        })
    }
    
    func setImageLink(_ link: String?, placeholder: UIImage? = nil, isCustomIndicator: Bool = false, completion: ((UIImage?, NSError?) -> Void)? = nil) {
        let url = link.flatMap { URL(string: $0) }
        self.setImageURL(url, placeholder: placeholder,isCustomIndicator: isCustomIndicator, completion: completion)
    }
}


class CustomIndicatorKF: Indicator {
    func startAnimatingView() {
        animatingCount += 1
        // Already animating
        if animatingCount == 1 {
            activityIndicatorView.startAnimating()
            activityIndicatorView.isHidden = false
        }
    }
    
    func stopAnimatingView() {
        animatingCount = max(animatingCount - 1, 0)
        if animatingCount == 0 {
            activityIndicatorView.stopAnimating()
            activityIndicatorView.isHidden = true
        }
    }
    
    var view: IndicatorView {
        return activityIndicatorView
    }
    
    private var activityIndicatorView: UIActivityIndicatorView
    
    private var animatingCount = 0
    
    init() {
        let indicatorStyle = UIActivityIndicatorView.Style.white
        activityIndicatorView = UIActivityIndicatorView(style: indicatorStyle)
        activityIndicatorView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleTopMargin]
    }
}
