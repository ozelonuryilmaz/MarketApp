//
//  MainTabbarCoordinator.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

class MainTabbarCoordinator: RootableCoordinator {

    var callbackIsPreparedMainScreen: (() -> Void)? = nil

    private lazy var mainTabbarController: MainTabbarController = {
        return MainTabbarController(tabbarControllerDelegate: self)
    }()

    override func start() {

        // Listing
        let listingNavController = MainNavigationController()
        listingNavController.tabBarItem.image = .tab_listing
        listingNavController.tabBarItem.selectedImage = .tab_listing_selected
        let listingCoordinator = ListingCoordinator(navigationController: listingNavController)

        // Cart
        let basketNavController = MainNavigationController()
        basketNavController.tabBarItem.image = .tab_cart
        basketNavController.tabBarItem.selectedImage = .tab_cart_selected
        let basketCoordinator = BasketCoordinator(navigationController: basketNavController)

        // Favorite
        let favoriteNavController = MainNavigationController()
        favoriteNavController.tabBarItem.image = .tab_favorite
        favoriteNavController.tabBarItem.selectedImage = .tab_favorite_selected
        let favoriteCoordinator = FavoriteCoordinator(navigationController: favoriteNavController)

        // Profile
        let profileNavController = MainNavigationController()
        profileNavController.tabBarItem.image = .tab_profile
        profileNavController.tabBarItem.selectedImage = .tab_profile_selected
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavController)

        // workerNavController
        mainTabbarController.viewControllers = [
            listingNavController,
            basketNavController,
            favoriteNavController,
            profileNavController
        ]

        window?.rootViewController = mainTabbarController
        window?.makeKeyAndVisible()

        // Coordinate to first controllers for tabs
        coordinate(to: listingCoordinator)
        coordinate(to: basketCoordinator)
        coordinate(to: favoriteCoordinator)
        coordinate(to: profileCoordinator)

        // Uygulamanın ilk açılış ekranı
        self.mainTabbarController.changeTabbarItemController(position: .listing)

        // uygulamaya giriş yapıldıktan 1 saniye sonra tetiklenen callback
        DispatchQueue.delay(1000) { [weak self] in
            self?.callbackIsPreparedMainScreen?()
        }
    }
}

// MARK: UITabBarControllerDelegate
extension MainTabbarCoordinator: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        return true
    }
}

// Tab Icons
fileprivate extension UIImage {
    static var tab_listing = UIImage(named: "ic_tab_1")!.withRenderingMode(.alwaysTemplate)
    static var tab_listing_selected = UIImage(named: "ic_tab_1_selected")!.withRenderingMode(.alwaysOriginal)

    static var tab_cart = UIImage(named: "ic_tab_2")!.withRenderingMode(.alwaysTemplate)
    static var tab_cart_selected = UIImage(named: "ic_tab_2_selected")!.withRenderingMode(.alwaysOriginal)

    static var tab_favorite = UIImage(named: "ic_tab_3")!.withRenderingMode(.alwaysTemplate)
    static var tab_favorite_selected = UIImage(named: "ic_tab_3_selected")!.withRenderingMode(.alwaysOriginal)
    
    static var tab_profile = UIImage(named: "ic_tab_4")!.withRenderingMode(.alwaysTemplate)
    static var tab_profile_selected = UIImage(named: "ic_tab_4_selected")!.withRenderingMode(.alwaysOriginal)
}

