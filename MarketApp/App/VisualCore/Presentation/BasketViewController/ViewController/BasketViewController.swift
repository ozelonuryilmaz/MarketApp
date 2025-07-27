//
//  BasketViewController.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

final class BasketViewController: MarketBaseViewController<BasketRootView> {

    // MARK: Injection
    private let viewModel: IBasketViewModel
    
    // MARK: Init
    init(viewModel: IBasketViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setupView() {
        
    }
    
    override func initialComponents() {
        observeViewState()
        listenErrorState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchCartItems()
    }

    // MARK: Bindings
    private func observeViewState() {
        viewModel.viewState
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.handle(state: state)
            }
            .store(in: &cancelBag)
    }
    
    private func handle(state: BasketViewState) {
        switch state {
        case .showLoadingProgress(let isProgress):
            self.playNativeLoading(isLoading: isProgress)
            
        }
    }
    
    private func listenErrorState() {
        //observeErrorState(errorState: viewModel.errorState)
    }
}

// MARK: Props
private extension BasketViewController {
    
}
