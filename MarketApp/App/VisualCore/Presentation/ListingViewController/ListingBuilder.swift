//
//  ListingBuilder.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

enum ListingBuilder {
    
    static func generate(coordinator: IListingCoordinator & BaseCoordinator,
                         delegate: ListingViewControllerDelegate?) -> ListingViewController {
        
        let repository: IListingRepository = ListingRepository()
        let data: ListingParams = coordinator.getParams()
        let vmLogic: IListingVMLogic = ListingVMLogic(data: data)
        
        let viewModel: IListingViewModel = ListingViewModel(
            repository: repository,
            coordinator: coordinator,
            vmLogic: vmLogic
        )

        return ListingViewController(
            viewModel: viewModel,
            delegate: delegate
        )
    }
}
