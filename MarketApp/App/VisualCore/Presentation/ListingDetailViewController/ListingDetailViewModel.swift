//
//  ListingDetailViewModel.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 27.07.2025.
//

import Foundation
import Combine

protocol IListingDetailViewModel: AnyObject {

    var viewState: ScreenStateSubject<ListingDetailViewState> { get }
    var errorState: ErrorStateSubject { get }
    
    init(repository: IListingDetailRepository,
         coordinator: IListingDetailCoordinator,
         vmLogic: IListingDetailVMLogic)
}

final class ListingDetailViewModel: BaseViewModel, IListingDetailViewModel {
    
    // MARK: Definitions
    private let repository: IListingDetailRepository
    private let coordinator: IListingDetailCoordinator
    private var vmLogic: IListingDetailVMLogic
    
    // MARK: Props
    var viewState = ScreenStateSubject<ListingDetailViewState>(nil)
    var errorState = ErrorStateSubject(nil)
    
    // MARK: Initiliazer
    required init(repository: IListingDetailRepository,
                  coordinator: IListingDetailCoordinator,
                  vmLogic: IListingDetailVMLogic) {
        self.repository = repository
        self.coordinator = coordinator
        self.vmLogic = vmLogic
        super.init()
    }
    
}


// MARK: Service
internal extension ListingDetailViewModel {
    
}

// MARK: States
internal extension ListingDetailViewModel {
    
    // MARK: View State
    func viewStateShowLoadingProgress(isProgress: Bool) {
        viewState.value = .showLoadingProgress(isProgress: isProgress)
    }
    
}

// MARK: Coordinate
internal extension ListingDetailViewModel {
    
}

enum ListingDetailViewState {
    case showLoadingProgress(isProgress: Bool)
}
