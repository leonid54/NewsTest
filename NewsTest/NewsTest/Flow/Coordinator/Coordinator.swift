import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    
    func start(_ vc: UIViewController)
}

extension Coordinator {
    func start(_ vc: UIViewController) {
        if let navigationController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
