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
    
    override var navigationTitle: String? {
        return "E-Market"
    }
    
    // MARK: Init
    init(viewModel: IBasketViewModel) {
        self.viewModel = viewModel
        super.init()
        rootView.delegate = self.viewModel
        rootView.setDataSource(delegate: self, dataSource: self)
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

// MARK: UITableViewDelegate & UITableViewDataSource
extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BasketCell.identifier, for: indexPath) as? BasketCell else { return UITableViewCell() }
        if let cellCartModel = self.viewModel.getCellCartModel(at: indexPath.row) {
            cell.configure(with: cellCartModel)
            cell.outputDelegate = self.viewModel
        }
        return cell
    }
}
