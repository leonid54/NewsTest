import UIKit

protocol ShowDetailInterface {
    func showDetail(for feed: Feed, hidesBottomBarWhenPushed: Bool)
}

struct DetailCoordinator: Coordinator {
    var hidesBottomBarWhenPushed = true
    var navigationController: UINavigationController?
    
    func showDetail(feed: Feed) {
        let detailModule = DetailViewController(model: DetailViewModel(feed: feed))
        start(detailModule)
    }
}

extension ShowDetailInterface where Self: UIViewController {
    func showDetail(for feed: Feed, hidesBottomBarWhenPushed: Bool) {
        let coordinator = DetailCoordinator( hidesBottomBarWhenPushed: hidesBottomBarWhenPushed, navigationController: navigationController)
        coordinator.showDetail(feed: feed)
    }
}
