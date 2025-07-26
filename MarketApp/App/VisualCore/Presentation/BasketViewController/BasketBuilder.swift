//
//  BasketBuilder.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

enum BasketBuilder {
    
    static func generate(coordinator: IBasketCoordinator & BaseCoordinator,
                         delegate: BasketViewControllerDelegate?) -> BasketViewController {
        
        let repository: IBasketRepository = BasketRepository()
        let data: BasketParams = coordinator.getParams()
        let vmLogic: IBasketVMLogic = BasketVMLogic(data: data)
        
        let viewModel: IBasketViewModel = BasketViewModel(
            repository: repository,
            coordinator: coordinator,
            vmLogic: vmLogic
        )

        return BasketViewController(
            viewModel: viewModel,
            delegate: delegate
        )
    }
}
