//
//  FilterCoordinator.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 27.07.2025.
//

protocol IFilterCoordinator: IPresentationCoordinator {
    
}

final class FilterCoordinator: PresentationCoordinator, IFilterCoordinator {

    private weak var delegate: FilterViewControllerDelegate?
    
    @discardableResult
    func with(delegate: FilterViewControllerDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    override func start() {
        let controller = FilterBuilder.generate(coordinator: self, delegate: delegate)
        controller.modalPresentationStyle = .pageSheet
        showScreen(viewController: controller)
    }
    
}
