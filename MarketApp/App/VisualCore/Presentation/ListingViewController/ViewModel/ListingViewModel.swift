//
//  ListingViewModel.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import Foundation
import Combine

protocol IListingViewModel: AnyObject {

    var viewState: ScreenStateSubject<ListingViewState> { get }
    var errorState: ErrorStateSubject { get }
    
    init(repository: IListingRepository,
         coordinator: IListingCoordinator,
         vmLogic: IListingVMLogic)
}

final class ListingViewModel: BaseViewModel, IListingViewModel {
    
    // MARK: Definitions
    private let repository: IListingRepository
    private let coordinator: IListingCoordinator
    private var vmLogic: IListingVMLogic
    
    // MARK: Props
    var viewState = ScreenStateSubject<ListingViewState>(nil)
    var errorState = ErrorStateSubject(nil)
    
    // MARK: Initiliazer
    required init(repository: IListingRepository,
                  coordinator: IListingCoordinator,
                  vmLogic: IListingVMLogic) {
        self.repository = repository
        self.coordinator = coordinator
        self.vmLogic = vmLogic
        super.init()
        
        fetchProducts()
    }
    
}


// MARK: Service
internal extension ListingViewModel {
    
    func fetchProducts() {
        handleResourceDataSource(
            request: repository.fetchProducts(page: 1, limit: 1),
            errorState: errorState,
            callbackLoading: { [weak self] isProgress in
                self?.viewStateShowLoadingProgress(isProgress: isProgress)
            }, callbackSuccess: { [weak self] response in
                print("Debug: 1** \(response)")
            })
    }
}

// MARK: States
internal extension ListingViewModel {
    
    // MARK: View State
    func viewStateShowLoadingProgress(isProgress: Bool) {
        viewState.value = .showLoadingProgress(isProgress: isProgress)
    }
}

// MARK: Coordinate
internal extension ListingViewModel {
    
}

enum ListingViewState {
    case showLoadingProgress(isProgress: Bool)
}
