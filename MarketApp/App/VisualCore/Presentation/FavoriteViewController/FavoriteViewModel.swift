//
//  FavoriteViewModel.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import Foundation
import Combine

protocol IFavoriteViewModel: AnyObject {

    var viewState: ScreenStateSubject<FavoriteViewState> { get }
    var errorState: ErrorStateSubject { get }
    
    init(repository: IFavoriteRepository,
         coordinator: IFavoriteCoordinator,
         vmLogic: IFavoriteVMLogic)
}

final class FavoriteViewModel: BaseViewModel, IFavoriteViewModel {
    
    // MARK: Definitions
    private let repository: IFavoriteRepository
    private let coordinator: IFavoriteCoordinator
    private var vmLogic: IFavoriteVMLogic
    
    // MARK: Props
    var viewState = ScreenStateSubject<FavoriteViewState>(nil)
    var errorState = ErrorStateSubject(nil)
    
    // MARK: Initiliazer
    required init(repository: IFavoriteRepository,
                  coordinator: IFavoriteCoordinator,
                  vmLogic: IFavoriteVMLogic) {
        self.repository = repository
        self.coordinator = coordinator
        self.vmLogic = vmLogic
        super.init()
    }
    
}


// MARK: Service
internal extension FavoriteViewModel {
    
}

// MARK: States
internal extension FavoriteViewModel {
    
    // MARK: View State
    func viewStateShowLoadingProgress(isProgress: Bool) {
        viewState.value = .showLoadingProgress(isProgress: isProgress)
    }
    
}

// MARK: Coordinate
internal extension FavoriteViewModel {
    
}

enum FavoriteViewState {
    case showLoadingProgress(isProgress: Bool)
}
