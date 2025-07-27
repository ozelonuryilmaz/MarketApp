//
//  ProfileViewController.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

final class ProfileViewController: MarketBaseViewController<ProfileRootView> {

    // MARK: Injection
    private let viewModel: IProfileViewModel
    
    override var navigationTitle: String? {
        return "Profil"
    }
    
    // MARK: Init
    init(viewModel: IProfileViewModel) {
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
    
    private func handle(state: ProfileViewState) {
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
private extension ProfileViewController {
    
}
