//
//  ListingViewController.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

protocol ListingViewControllerDelegate: AnyObject {
    
}

final class ListingViewController: MarketBaseViewController<ListingRootView> {
    
    // MARK: Injection
    private let viewModel: IListingViewModel
    
    override var navigationTitle: String? {
        return "E-Market"
    }
    
    // MARK: Init
    init(viewModel: IListingViewModel) {
        self.viewModel = viewModel
        super.init()
        self.rootView.delegate = self.viewModel
    }
    
    override func setupView() {
        setupKeyboardDismissGesture()
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
    
    private func handle(state: ListingViewState) {
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
private extension ListingViewController {
    
    func setupKeyboardDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
