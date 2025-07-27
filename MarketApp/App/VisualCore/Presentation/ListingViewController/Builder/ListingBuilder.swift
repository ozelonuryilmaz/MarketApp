//
//  ListingBuilder.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

enum ListingBuilder {
    
    static func generate(coordinator: IListingCoordinator) -> ListingViewController {
        
        let fetchProductUseCase: IFetchProductUseCase = ProductUseCaseProvider.makeFetchProductUseCase()
        let addToCartUseCase: IAddToCartUseCase = CartUseCaseProvider.makeAddToCartUseCase()
        let repository: IListingRepository = ListingRepository(fetchProductUseCase: fetchProductUseCase,
                                                               addToCartUseCase: addToCartUseCase)

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
