//
//  ListingViewModel.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import Foundation
import Combine

protocol IListingViewModel: ListingRootViewDelegate,
                            ListingProductCellOutputDelegate {
    
    var viewState: ScreenStateSubject<ListingViewState> { get }
    var errorState: ErrorStateSubject { get }
    
    init(repository: IListingRepository,
         coordinator: IListingCoordinator,
         vmLogic: IListingVMLogic)
    
    // Fetch Product Data
    func fetchProductsListPagination()
    func fetctFirstProductsList()
    
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
    
    // Fetch Product Data
    func fetchProductsListPagination() {
        if self.vmLogic.fetchProductsPagination() {
            self.fetchProducts()
        }
    }
    
    func fetctFirstProductsList() {
        self.vmLogic.clearRequest()
        self.fetchProducts()
    }
}

// MARK: Service
internal extension ListingViewModel {
    
    private func fetchProducts() {
        handleResourceDataSource(
            request: repository.fetchProducts(page: vmLogic.pageNumber,
                                              limit: vmLogic.pageSize,
                                              name: vmLogic.searchText),
            errorState: errorState,
            callbackLoading: { [weak self] isProgress in
                self?.viewStateShowLoadingProgress(isProgress: isProgress)
            },
            callbackSuccess: { [weak self] response in
                guard let self, let response else { return }
                self.vmLogic.addResponse(response)
                self.vmLogic.reachLastPagePagination(products: response)
                self.viewStateReloadProductData()
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
    private func viewStateShowLoadingProgress(isProgress: Bool) {
        viewState.value = .showLoadingProgress(isProgress: isProgress)
    }
    
    private func viewStateReloadProductData() {
        viewState.value = .reloadProductData
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
        fetctFirstProductsList()
    }
}

// MARK: ListingProductCellOutputDelegate
internal extension ListingViewModel {
    
    func listingProductCellDidTap(product: ProductEntity) {
        print("Debug: listingProductCellDidTapContentView")
    }
    
    func listingProductCellDidTapAddToCart(product: ProductEntity) {
        print("Debug: listingProductCellDidTapAddToCart")
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
    case reloadProductData
}
