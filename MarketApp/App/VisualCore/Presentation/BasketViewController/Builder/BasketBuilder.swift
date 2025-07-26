//
//  BasketBuilder.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

enum BasketBuilder {
    
    static func generate(coordinator: IBasketCoordinator) -> BasketViewController {
        
        let repository: IBasketRepository = BasketRepository()
        let vmLogic: IBasketVMLogic = BasketVMLogic()
        
        let viewModel: IBasketViewModel = BasketViewModel(
            repository: repository,
            coordinator: coordinator,
            vmLogic: vmLogic
        )

        return BasketViewController(
            viewModel: viewModel
        )
    }
}
