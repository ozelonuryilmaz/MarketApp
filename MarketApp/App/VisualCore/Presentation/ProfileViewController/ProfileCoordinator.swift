//
//  ProfileCoordinator.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

protocol IProfileCoordinator: INavigationCoordinator {
    
}

final class ProfileCoordinator: NavigationCoordinator, IProfileCoordinator {

    private weak var delegate: ProfileViewControllerDelegate?
    
    @discardableResult
    func with(delegate: ProfileViewControllerDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    override func start() {
        let controller = ProfileBuilder.generate(coordinator: self, delegate: delegate)
        //controller.modalPresentationStyle = .fullScreen
        showScreen(viewController: controller)
    }
    
}
