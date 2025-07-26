//
//  FavoriteCoordinator.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

protocol IFavoriteCoordinator: INavigationCoordinator {
    
}

final class FavoriteCoordinator: NavigationCoordinator, IFavoriteCoordinator {

    private weak var delegate: FavoriteViewControllerDelegate?
    
    @discardableResult
    func with(delegate: FavoriteViewControllerDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    override func start() {
        let controller = FavoriteBuilder.generate(coordinator: self, delegate: delegate)
        //controller.modalPresentationStyle = .fullScreen
        showScreen(viewController: controller)
    }
    
}
