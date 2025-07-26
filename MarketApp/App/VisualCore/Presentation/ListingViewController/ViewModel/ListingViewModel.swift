//
//  ListingViewModel.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import Foundation
import Combine

protocol IListingViewModel: ListingRootViewDelegate {
    
    var viewState: ScreenStateSubject<ListingViewState> { get }
    var errorState: ErrorStateSubject { get }
    
    init(repository: IListingRepository,
         coordinator: IListingCoordinator,
         vmLogic: IListingVMLogic)
    
    func fetchProductsPagination()
    func firstProductsList()
    
    // CollectionView
    func numberOfRowsInSection() -> Int
    func getCellProductModel(at index: Int) -> ProductEntity
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
    }
    
    // Pagination
    func fetchProductsPagination() {
        if self.vmLogic.fetchProductsPagination() {
            self.fetchProducts()
        }
    }
    
    func firstProductsList() {
        self.vmLogic.clearRequest()
        self.fetchProducts()
    }
}



// MARK: Service
internal extension ListingViewModel {
    
    func fetchProducts() {
        handleResourceDataSource(
            request: repository.fetchProducts(page: vmLogic.pageSize, limit: vmLogic.pageNumber, name: vmLogic.searchText),
            errorState: errorState,
            callbackLoading: { [weak self] isProgress in
                self?.viewStateShowLoadingProgress(isProgress: isProgress)
            },
            callbackSuccess: { [weak self] response in
                guard let self, let response else { return }
                self.vmLogic.products = response
                // TODO: Pagination gelen eskinin üzerime eklenmeli
                // TODO: reloadData
            },
            callbackComplete: { [weak self] in
                guard let self = self else { return }
                self.vmLogic.stopPagination()
            }
        )
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

// MARK: ListingRootViewDelegate
internal extension ListingViewModel {
    
    func listingViewDidTapFilter() {
        print("Debug: listingViewDidTapFilter")
    }
    
    func listingViewSearchTextDidChange(_ text: String) {
        vmLogic.searchText = text
        firstProductsList()
    }
}

// MARK: CollectionView
internal extension ListingViewModel {
    
    func numberOfRowsInSection() -> Int {
        return vmLogic.numberOfRowsInSection()
    }
    
    func getCellProductModel(at index: Int) -> ProductEntity {
        return vmLogic.getCellProductModel(at: index)
    }
}

enum ListingViewState {
    case showLoadingProgress(isProgress: Bool)
}
