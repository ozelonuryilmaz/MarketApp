//
//  ListingBuilder.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

enum ListingBuilder {
    
    static func generate(coordinator: IListingCoordinator) -> ListingViewController {
        
        let productUseCase: IProductUseCase = ProductUseCaseProvider.makeProductUseCase()
        let repository: IListingRepository = ListingRepository(productUseCase: productUseCase)

        let vmLogic: IListingVMLogic = ListingVMLogic()
        
        let viewModel: IListingViewModel = ListingViewModel(
            repository: repository,
            coordinator: coordinator,
            vmLogic: vmLogic
        )

        return ListingViewController(
            viewModel: viewModel
        )
    }
}
