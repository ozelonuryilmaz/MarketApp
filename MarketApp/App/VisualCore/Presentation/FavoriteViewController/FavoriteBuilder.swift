//
//  FavoriteBuilder.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

enum FavoriteBuilder {
    
    static func generate(coordinator: IFavoriteCoordinator & BaseCoordinator,
                         delegate: FavoriteViewControllerDelegate?) -> FavoriteViewController {
        
        let repository: IFavoriteRepository = FavoriteRepository()
        let data: FavoriteParams = coordinator.getParams()
        let vmLogic: IFavoriteVMLogic = FavoriteVMLogic(data: data)
        
        let viewModel: IFavoriteViewModel = FavoriteViewModel(
            repository: repository,
            coordinator: coordinator,
            vmLogic: vmLogic
        )

        return FavoriteViewController(
            viewModel: viewModel,
            delegate: delegate
        )
    }
}
