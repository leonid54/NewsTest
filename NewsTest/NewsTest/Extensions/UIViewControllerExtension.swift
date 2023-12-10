import UIKit

fileprivate struct Constants {
    static let toastAlpha: CGFloat = 1
    static let toastCornerRad: CGFloat = 15
    static let intervalShowing = 1.5
    static let alertTitle = "Ok"
}

extension UIViewController {
    func showToast(message: String, interval: Double = Constants.intervalShowing, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        alert.view.backgroundColor = .blue
        alert.view.alpha = Constants.toastAlpha
        alert.view.layer.cornerRadius = Constants.toastCornerRad
        
        let cancelAction = UIAlertAction(title: Constants.alertTitle, style: .cancel) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + interval) {
            alert.dismiss(animated: true, completion: nil)
            completion?()
        }
    }
}
