//
//  ProfileBuilder.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

enum ProfileBuilder {
    
    static func generate(coordinator: IProfileCoordinator) -> ProfileViewController {
        
        let repository: IProfileRepository = ProfileRepository()
        let vmLogic: IProfileVMLogic = ProfileVMLogic()
        
        let viewModel: IProfileViewModel = ProfileViewModel(
            repository: repository,
            coordinator: coordinator,
            vmLogic: vmLogic
        )

        return ProfileViewController(
            viewModel: viewModel
        )
    }
}
