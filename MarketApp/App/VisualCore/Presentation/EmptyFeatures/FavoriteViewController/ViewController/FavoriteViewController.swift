//
//  FavoriteViewController.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

final class FavoriteViewController: MarketBaseViewController<FavoriteRootView> {
    
    // MARK: Injection
    private let viewModel: IFavoriteViewModel
    
    override var navigationTitle: String? {
        return "Favori"
    }
    
    // MARK: Init
    init(viewModel: IFavoriteViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setupView() {
        
    }
    
    override func initialComponents() {
        observeViewState()
        listenErrorState()
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
    
    private func handle(state: FavoriteViewState) {
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
private extension FavoriteViewController {
    
}
