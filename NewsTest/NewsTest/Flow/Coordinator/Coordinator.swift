import UIKit

protocol Coordinator {
    var hidesBottomBarWhenPushed: Bool { get set }
    var navigationController: UINavigationController? { get set }
    
    func start(_ vc: UIViewController)
}

extension Coordinator {
    func start(_ vc: UIViewController) {
        vc.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
        if let navigationController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
