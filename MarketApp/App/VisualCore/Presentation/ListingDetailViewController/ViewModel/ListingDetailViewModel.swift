//
//  ListingDetailViewModel.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 27.07.2025.
//

import Foundation
import Combine

protocol IListingDetailViewModel: ListingDetailRootViewDelegate {
    
    var viewState: ScreenStateSubject<ListingDetailViewState> { get }
    var errorState: ErrorStateSubject { get }
    
    var navigationTitle: String { get }
    
    init(repository: IListingDetailRepository,
         coordinator: IListingDetailCoordinator,
         vmLogic: IListingDetailVMLogic)
    
    // ViewState
    func viewStateConfigureView()
}

final class ListingDetailViewModel: BaseViewModel, IListingDetailViewModel {
    
    // MARK: Definitions
    private let repository: IListingDetailRepository
    private let coordinator: IListingDetailCoordinator
    private var vmLogic: IListingDetailVMLogic
    
    // MARK: Props
    var viewState = ScreenStateSubject<ListingDetailViewState>(nil)
    var errorState = ErrorStateSubject(nil)
    
    var navigationTitle: String {
        return vmLogic.navigationTitle
    }
    
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
    
    private func addToCart(item: CartEntity) {
        handleResourceDataSource(
            request: repository.addToCart(item: item),
            errorState: errorState,
            callbackLoading: { [weak self] isProgress in
                self?.viewStateShowLoadingProgress(isProgress: isProgress)
            },
            callbackSuccess: { [weak self] response in
                guard let _ = self, let response else { return }
                print("Debug: addToCart: \(response)")
            }
        )
    }
}

// MARK: View State
internal extension ListingDetailViewModel {
    
    private func viewStateShowLoadingProgress(isProgress: Bool) {
        viewState.value = .showLoadingProgress(isProgress: isProgress)
    }
    
    func viewStateConfigureView() {
        viewState.value = .configureView(product: vmLogic.product)
    }
}

// MARK: Coordinate
internal extension ListingDetailViewModel {
    
}

// MARK: ListingDetailRootViewDelegate
internal extension ListingDetailViewModel {
    
    func listingDetailViewDidTapAddToCart() {
        addToCart(item: vmLogic.cart)
    }
}

enum ListingDetailViewState {
    case showLoadingProgress(isProgress: Bool)
    case configureView(product: ProductEntity)
}
