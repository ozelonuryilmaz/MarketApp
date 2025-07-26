//
//  ProfileBuilder.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

enum ProfileBuilder {
    
    static func generate(coordinator: IProfileCoordinator & BaseCoordinator,
                         delegate: ProfileViewControllerDelegate?) -> ProfileViewController {
        
        let repository: IProfileRepository = ProfileRepository()
        let data: ProfileParams = coordinator.getParams()
        let vmLogic: IProfileVMLogic = ProfileVMLogic(data: data)
        
        let viewModel: IProfileViewModel = ProfileViewModel(
            repository: repository,
            coordinator: coordinator,
            vmLogic: vmLogic
        )

        return ProfileViewController(
            viewModel: viewModel,
            delegate: delegate
        )
    }
}
