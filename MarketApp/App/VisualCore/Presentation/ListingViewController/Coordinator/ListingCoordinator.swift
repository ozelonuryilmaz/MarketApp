//
//  ListingCoordinator.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

protocol IListingCoordinator: INavigationCoordinator {
    
    func pushListingDetailViewController(params: ListingDetailParams)
    func presentFilterViewController()
}

final class ListingCoordinator: NavigationCoordinator, IListingCoordinator {

    override func start() {
        let controller = ListingBuilder.generate(coordinator: self)
        controller.modalPresentationStyle = .fullScreen
        showScreen(viewController: controller)
    }
    
    func pushListingDetailViewController(params: ListingDetailParams) {
        let coordinator = ListingDetailCoordinator(navigationController: currentNavigationController())
            .with(data: params)
        coordinate(to: coordinator)
    }
    
    func presentFilterViewController() {
        let coordinator = FilterCoordinator(presenterViewController: currentNavigationController())
            .with(data: FilterParams())// TODO: Pass data to VMLogic via Params when navigating to the filter screen
            //.with(delegate: delegate) // TODO: Activate delegate to pass data back to the previous screen(ViewModel)
        coordinate(to: coordinator)
    }
}
