//
//  BasketViewModel.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import Foundation
import Combine

protocol IBasketViewModel: AnyObject {

    var viewState: ScreenStateSubject<BasketViewState> { get }
    var errorState: ErrorStateSubject { get }
    
    init(repository: IBasketRepository,
         coordinator: IBasketCoordinator,
         vmLogic: IBasketVMLogic)
}

final class BasketViewModel: BaseViewModel, IBasketViewModel {
    
    // MARK: Definitions
    private let repository: IBasketRepository
    private let coordinator: IBasketCoordinator
    private var vmLogic: IBasketVMLogic
    
    // MARK: Props
    var viewState = ScreenStateSubject<BasketViewState>(nil)
    var errorState = ErrorStateSubject(nil)
    
    // MARK: Initiliazer
    required init(repository: IBasketRepository,
                  coordinator: IBasketCoordinator,
                  vmLogic: IBasketVMLogic) {
        self.repository = repository
        self.coordinator = coordinator
        self.vmLogic = vmLogic
        super.init()
    }
    
}


// MARK: Service
internal extension BasketViewModel {
    
}

// MARK: States
internal extension BasketViewModel {
    
    // MARK: View State
    func viewStateShowLoadingProgress(isProgress: Bool) {
        viewState.value = .showLoadingProgress(isProgress: isProgress)
    }
    
}

// MARK: Coordinate
internal extension BasketViewModel {
    
}

enum BasketViewState {
    case showLoadingProgress(isProgress: Bool)
}
