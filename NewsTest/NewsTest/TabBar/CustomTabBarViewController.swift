import UIKit

fileprivate struct Constants {
    static let newsTitle = "Лента"
    static let favoritesTitle = "Избранное"
    static let newsImageTitle = "newspaper"
    static let newsFillImageTitle = "newspaper.fill"
    static let favImageTitle = "star"
    static let favFillImageTitle = "star.fill"
    static let tabBarFontSize: CGFloat = 8
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
        let feedViewModel = FeedViewModel()
        let favoritesViewModel = FavoritesViewModel()
        
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
        
        if #available(iOS 15, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.backgroundColor = .clear
            navigationBarAppearance.backgroundImage = nil
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
        
        let tabBarApperance = UITabBarAppearance()
        tabBarApperance.configureWithTransparentBackground()
        tabBarApperance.backgroundColor = UIColor.green
        UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
        UITabBar.appearance().standardAppearance = tabBarApperance
                
        let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.tabBarFontSize, weight: .medium)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes as [NSAttributedString.Key: Any], for: .normal)
    }
}
