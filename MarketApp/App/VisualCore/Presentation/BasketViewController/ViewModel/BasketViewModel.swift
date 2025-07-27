//
//  BasketViewModel.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import Foundation
import Combine

protocol IBasketViewModel: BasketRootViewDelegate,
                           BasketCellOutputDelegate {

    var viewState: ScreenStateSubject<BasketViewState> { get }
    var errorState: ErrorStateSubject { get }
    
    init(repository: IBasketRepository,
         coordinator: IBasketCoordinator,
         vmLogic: IBasketVMLogic)
    
    // Service
    func fetchCartItems()
    
    // TableView
    func numberOfRowsInSection() -> Int
    func getCellCartModel(at index: Int) -> CartEntity?
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
    
    func fetchCartItems() {
        handleResourceDataSource(
            request: repository.fetchCartItems(),
            errorState: errorState,
            callbackLoading: { [weak self] isProgress in
                self?.viewStateShowLoadingProgress(isProgress: isProgress)
            },
            callbackSuccess: { [weak self] response in
                guard let self, let response else { return }
                self.vmLogic.setResponse(response)
                self.viewStateSetTotalPrice()
                self.viewStateReloadCartData()
            }
        )
    }
}

// MARK: View State
internal extension BasketViewModel {
    
    func viewStateShowLoadingProgress(isProgress: Bool) {
        viewState.value = .showLoadingProgress(isProgress: isProgress)
    }
    
    private func viewStateReloadCartData() {
        viewState.value = .reloadCartData
    }
    
    private func viewStateSetTotalPrice() {
        viewState.value = .setTotalPrice(price: vmLogic.totalPrice)
    }
}

// MARK: Coordinate
internal extension BasketViewModel {
    
}

// MARK: BasketRootViewDelegate
internal extension BasketViewModel {
    
    func basketViewDidTapComplete() {
        print("Debug: *** basketViewDidTapComplete")
    }
}

// MARK: BasketCellOutputDelegate
internal extension BasketViewModel {
    
    func basketCellDidTapMinus(cart: CartEntity) {
        print("Debug: *** basketCellDidTapMinus")
    }
    
    func basketCellDidTapPlus(cart: CartEntity) {
        print("Debug: *** basketCellDidTapPlus")
    }
}

// MARK: TableView
internal extension BasketViewModel {
    
    func numberOfRowsInSection() -> Int {
        return vmLogic.numberOfRowsInSection()
    }
    
    func getCellCartModel(at index: Int) -> CartEntity? {
        return vmLogic.getCellCartModel(at: index)
    }
}

enum BasketViewState {
    case showLoadingProgress(isProgress: Bool)
    case reloadCartData
    case setTotalPrice(price: String)
}
