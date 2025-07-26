//
//  ListingCoordinator.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

protocol IListingCoordinator: INavigationCoordinator {
    
}

final class ListingCoordinator: NavigationCoordinator, IListingCoordinator {

    private weak var delegate: ListingViewControllerDelegate?
    
    @discardableResult
    func with(delegate: ListingViewControllerDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    override func start() {
        let controller = ListingBuilder.generate(coordinator: self, delegate: delegate)
        //controller.modalPresentationStyle = .fullScreen
        showScreen(viewController: controller)
    }
    
}
