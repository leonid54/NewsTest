import UIKit

fileprivate struct Constants {
    static let newsTitle = "Лента"
    static let favoritesTitle = "Избранное"
    static let newsImageTitle = "newspaper"
    static let newsFillImageTitle = "newspaper.fill"
    static let favImageTitle = "star"
    static let favFillImageTitle = "star.fill"
}

final class CustomTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }
}

private extension CustomTabBarViewController {

    func setupInitialState() {
        setVC()
        setupTabBar()
        setTabBarAppearance()
    }

    func setVC() {
        let feedViewModel = FeedViewModel(feed: [Feed.init(articleID: "", creator: [""], imageURL: "", description: "", link: "", pubDate: "")])
        let favoritesViewModel = FavoritesViewModel(feed: [Feed.init(articleID: "", creator: [""], imageURL: "", description: "", link: "", pubDate: "")])
        
        let viewControllers = [
            FeedViewController(model: feedViewModel),
            FavoritesViewController(model: favoritesViewModel)
        ]
        
        let imagesName = [Constants.newsImageTitle, Constants.favImageTitle]
        let images = imagesName.map { UIImage(systemName: $0) }

        let selectedImagesName = [Constants.newsFillImageTitle, Constants.favFillImageTitle]
        let selectedImages = selectedImagesName.map { UIImage(systemName: $0) }

        let titles = [Constants.newsTitle, Constants.favoritesTitle]

        self.viewControllers = viewControllers.enumerated().map({ index, controller in
            controller.tabBarItem = UITabBarItem(
                title: titles[index],
                image: images[index],
                selectedImage: selectedImages[index]
            )
            return UINavigationController(rootViewController: controller)
        })

    }
    
    func setupTabBar() {
        tabBar.barTintColor = .white
        tabBar.unselectedItemTintColor = .gray
    }
    
    func setTabBarAppearance() {
        let tabBarApperance = UITabBarAppearance()
        tabBarApperance.configureWithTransparentBackground()
        tabBarApperance.backgroundColor = UIColor.green
        UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
        UITabBar.appearance().standardAppearance = tabBarApperance
                
        let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 8, weight: .medium)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes as [NSAttributedString.Key: Any], for: .normal)
    }
}
