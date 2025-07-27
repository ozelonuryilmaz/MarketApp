//
//  FilterViewModel.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 27.07.2025.
//

import Foundation
import Combine

protocol IFilterViewModel: AnyObject {

    var viewState: ScreenStateSubject<FilterViewState> { get }
    var errorState: ErrorStateSubject { get }
    
    init(repository: IFilterRepository,
         coordinator: IFilterCoordinator,
         vmLogic: IFilterVMLogic)
}

final class FilterViewModel: BaseViewModel, IFilterViewModel {
    
    // MARK: Definitions
    private let repository: IFilterRepository
    private let coordinator: IFilterCoordinator
    private var vmLogic: IFilterVMLogic
    
    // MARK: Props
    var viewState = ScreenStateSubject<FilterViewState>(nil)
    var errorState = ErrorStateSubject(nil)
    
    // MARK: Initiliazer
    required init(repository: IFilterRepository,
                  coordinator: IFilterCoordinator,
                  vmLogic: IFilterVMLogic) {
        self.repository = repository
        self.coordinator = coordinator
        self.vmLogic = vmLogic
        super.init()
    }
    
}


// MARK: Service
internal extension FilterViewModel {
    
}

// MARK: States
internal extension FilterViewModel {
    
    // MARK: View State
    func viewStateShowLoadingProgress(isProgress: Bool) {
        viewState.value = .showLoadingProgress(isProgress: isProgress)
    }
    
}

// MARK: Coordinate
internal extension FilterViewModel {
    
}

enum FilterViewState {
    case showLoadingProgress(isProgress: Bool)
}
