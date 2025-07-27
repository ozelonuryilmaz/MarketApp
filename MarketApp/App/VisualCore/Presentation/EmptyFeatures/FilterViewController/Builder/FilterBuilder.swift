//
//  FilterBuilder.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 27.07.2025.
//

import UIKit

enum FilterBuilder {
    
    static func generate(coordinator: IFilterCoordinator & BaseCoordinator,
                         delegate: FilterViewControllerDelegate?) -> FilterViewController {
        
        let repository: IFilterRepository = FilterRepository()
        let data: FilterParams = coordinator.getParams()
        let vmLogic: IFilterVMLogic = FilterVMLogic(data: data)
        
        let viewModel: IFilterViewModel = FilterViewModel(
            repository: repository,
            coordinator: coordinator,
            vmLogic: vmLogic
        )

        return FilterViewController(
            viewModel: viewModel,
            delegate: delegate
        )
    }
}
