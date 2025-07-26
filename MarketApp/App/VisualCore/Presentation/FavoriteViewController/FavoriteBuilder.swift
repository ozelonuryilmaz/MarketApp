//
//  FavoriteBuilder.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

enum FavoriteBuilder {
    
    static func generate(coordinator: IFavoriteCoordinator) -> FavoriteViewController {
        
        let repository: IFavoriteRepository = FavoriteRepository()
        let vmLogic: IFavoriteVMLogic = FavoriteVMLogic()
        
        let viewModel: IFavoriteViewModel = FavoriteViewModel(
            repository: repository,
            coordinator: coordinator,
            vmLogic: vmLogic
        )

        return FavoriteViewController(
            viewModel: viewModel
        )
    }
}
