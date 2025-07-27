//
//  ListingDetailViewController.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 27.07.2025.
//

import UIKit

protocol ListingDetailViewControllerDelegate: AnyObject {
    
}

final class ListingDetailViewController: MarketBaseViewController<ListingDetailRootView> {
    
    private weak var delegate: ListingDetailViewControllerDelegate?
    
    // MARK: Injection
    private let viewModel: IListingDetailViewModel
    
    // MARK: Init
    init(viewModel: IListingDetailViewModel,
         delegate: ListingDetailViewControllerDelegate? = nil) {
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
    
    private func handle(state: ListingDetailViewState) {
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
private extension ListingDetailViewController {
    
}
