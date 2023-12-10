import UIKit

protocol BackRouting {
    func goBack(animated: Bool, completion: SimpleClosure?)
}

extension BackRouting where Self: UIViewController {
    func goBack(animated: Bool, completion: SimpleClosure? = nil) {
        guard let navigationController else {
            dismiss(animated: animated, completion: completion)
            return
        }
        
        if navigationController.viewControllers.first == self {
            dismiss(animated: animated)
        } else {
            navigationController.popViewController(animated: animated)
        }
    }
}
