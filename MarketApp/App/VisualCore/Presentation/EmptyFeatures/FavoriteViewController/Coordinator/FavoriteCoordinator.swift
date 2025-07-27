//
//  FavoriteCoordinator.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

protocol IFavoriteCoordinator: INavigationCoordinator {
    
}

final class FavoriteCoordinator: NavigationCoordinator, IFavoriteCoordinator {

    override func start() {
        let controller = FavoriteBuilder.generate(coordinator: self)
        controller.modalPresentationStyle = .fullScreen
        showScreen(viewController: controller)
    }
    
}
