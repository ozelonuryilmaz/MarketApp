//
//  ProfileCoordinator.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

protocol IProfileCoordinator: INavigationCoordinator {
    
}

final class ProfileCoordinator: NavigationCoordinator, IProfileCoordinator {

    override func start() {
        let controller = ProfileBuilder.generate(coordinator: self)
        //controller.modalPresentationStyle = .fullScreen
        showScreen(viewController: controller)
    }
    
}
