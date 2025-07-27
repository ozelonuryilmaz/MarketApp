//
//  ListingDetailCoordinator.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 27.07.2025.
//

protocol IListingDetailCoordinator: INavigationCoordinator {
    
}

final class ListingDetailCoordinator: NavigationCoordinator, IListingDetailCoordinator {

    private weak var delegate: ListingDetailViewControllerDelegate?
    
    @discardableResult
    func with(delegate: ListingDetailViewControllerDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    override func start() {
        let controller = ListingDetailBuilder.generate(coordinator: self, delegate: delegate)
        showScreen(viewController: controller)
    }
    
}
