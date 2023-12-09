import UIKit

protocol ShowDetailInterface {
    func showDetail(for feed: Feed)
}

struct DetailCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func showDetail(feed: Feed) {
        let detailModule = DetailViewController(model: DetailViewModel(feed: feed))
        start(detailModule)
    }
}

extension ShowDetailInterface where Self: UIViewController {
    func showDetail(for feed: Feed) {
        let coordinator = DetailCoordinator(navigationController: navigationController)
        coordinator.showDetail(feed: feed)
    }
}
