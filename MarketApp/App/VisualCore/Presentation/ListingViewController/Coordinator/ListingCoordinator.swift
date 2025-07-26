//
//  ListingCoordinator.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

protocol IListingCoordinator: INavigationCoordinator {
    
}

final class ListingCoordinator: NavigationCoordinator, IListingCoordinator {

    
    override func start() {
        let controller = ListingBuilder.generate(coordinator: self)
        //controller.modalPresentationStyle = .fullScreen
        showScreen(viewController: controller)
    }
    
}
