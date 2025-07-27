//
//  ListingDetailBuilder.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 27.07.2025.
//

import UIKit

enum ListingDetailBuilder {
    
    static func generate(coordinator: IListingDetailCoordinator & BaseCoordinator,
                         delegate: ListingDetailViewControllerDelegate?) -> ListingDetailViewController {
        
        let repository: IListingDetailRepository = ListingDetailRepository()
        let data: ListingDetailParams = coordinator.getParams()
        let vmLogic: IListingDetailVMLogic = ListingDetailVMLogic(data: data)
        
        let viewModel: IListingDetailViewModel = ListingDetailViewModel(
            repository: repository,
            coordinator: coordinator,
            vmLogic: vmLogic
        )

        return ListingDetailViewController(
            viewModel: viewModel,
            delegate: delegate
        )
    }
}
