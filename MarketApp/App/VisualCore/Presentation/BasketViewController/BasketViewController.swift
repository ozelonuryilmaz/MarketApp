//
//  BasketViewController.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

protocol BasketViewControllerDelegate: AnyObject {
    
}

final class BasketViewController: MarketBaseViewController<BasketRootView> {
    
    private weak var delegate: BasketViewControllerDelegate?
    
    // MARK: Injection
    private let viewModel: IBasketViewModel
    
    // MARK: Init
    init(viewModel: IBasketViewModel,
         delegate: BasketViewControllerDelegate? = nil) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init()
    }
    
    override func setupView() {
        
    }
    
    override func initialComponents() {
        observeViewState()
        listenErrorState()
    }
 
    /*override func setLayoutStyle() -> (top: EdgeLayoutStyle, leading: EdgeLayoutStyle, bottom: EdgeLayoutStyle, trailing: EdgeLayoutStyle) {
        return (.safeArea, .safeArea, .safeArea, .safeArea)
    }*/
    
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
    
    private func handle(state: BasketViewState?) {
        guard let state = state else { return }
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
