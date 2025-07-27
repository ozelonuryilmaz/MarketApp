//
//  BasketCoordinator.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

protocol IBasketCoordinator: INavigationCoordinator {
    
}

final class BasketCoordinator: NavigationCoordinator, IBasketCoordinator {

    override func start() {
        let controller = BasketBuilder.generate(coordinator: self)
        controller.modalPresentationStyle = .fullScreen
        showScreen(viewController: controller)
    }
    
}
