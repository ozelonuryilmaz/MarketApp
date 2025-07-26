//
//  BasketCoordinator.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

protocol IBasketCoordinator: INavigationCoordinator {
    
}

final class BasketCoordinator: NavigationCoordinator, IBasketCoordinator {

    private weak var delegate: BasketViewControllerDelegate?
    
    @discardableResult
    func with(delegate: BasketViewControllerDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    override func start() {
        let controller = BasketBuilder.generate(coordinator: self, delegate: delegate)
        //controller.modalPresentationStyle = .fullScreen
        showScreen(viewController: controller)
    }
    
}
