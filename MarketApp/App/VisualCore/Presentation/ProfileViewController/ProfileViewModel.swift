//
//  ProfileViewModel.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import Foundation
import Combine

protocol IProfileViewModel: AnyObject {

    var viewState: ScreenStateSubject<ProfileViewState> { get }
    var errorState: ErrorStateSubject { get }
    
    init(repository: IProfileRepository,
         coordinator: IProfileCoordinator,
         vmLogic: IProfileVMLogic)
}

final class ProfileViewModel: BaseViewModel, IProfileViewModel {
    
    // MARK: Definitions
    private let repository: IProfileRepository
    private let coordinator: IProfileCoordinator
    private var vmLogic: IProfileVMLogic
    
    // MARK: Props
    var viewState = ScreenStateSubject<ProfileViewState>(nil)
    var errorState = ErrorStateSubject(nil)
    
    // MARK: Initiliazer
    required init(repository: IProfileRepository,
                  coordinator: IProfileCoordinator,
                  vmLogic: IProfileVMLogic) {
        self.repository = repository
        self.coordinator = coordinator
        self.vmLogic = vmLogic
        super.init()
    }
    
}


// MARK: Service
internal extension ProfileViewModel {
    
}

// MARK: States
internal extension ProfileViewModel {
    
    // MARK: View State
    func viewStateShowLoadingProgress(isProgress: Bool) {
        viewState.value = .showLoadingProgress(isProgress: isProgress)
    }
    
}

// MARK: Coordinate
internal extension ProfileViewModel {
    
}

enum ProfileViewState {
    case showLoadingProgress(isProgress: Bool)
}
