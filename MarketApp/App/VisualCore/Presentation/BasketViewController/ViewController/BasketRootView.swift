//
//  BasketRootView.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

protocol BasketRootViewDelegate: AnyObject {
    
    func basketViewDidTapComplete()
}

// TODO: Adjust layout for pixel-perfect alignment
final class BasketRootView: BaseRootView {
    
    weak var delegate: BasketRootViewDelegate?
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setDataSource(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        
        reloadCartData()
    }
    
    func reloadCartData() {
        tableView.reloadData()
    }
    
    // MARK: Definitions
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        tv.backgroundColor = .white
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = true
        tv.showsHorizontalScrollIndicator = false
        tv.alwaysBounceVertical = true
        tv.register(BasketCell.self, forCellReuseIdentifier: BasketCell.identifier)
        return tv
    }()
    
    
    // TODO: Extract bottomContainer from ListingDetailRootView and BasketRootView into a shared component
    private let bottomContainer = UIView()
    
    private lazy var priceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Total:"
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .systemBlue
        return label
    }()
    
    private lazy var priceValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    lazy var completeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Complete", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .heavy)
        button.addTarget(self, action: #selector(basketViewDidTapCompleteButton), for: .touchUpInside)
        return button
    }()
    
}

// MARK: Setup
private extension BasketRootView {
    
    func setupUI() {
        setupContentViews()
        setupBottomBarContent()
    }
    
    func setupContentViews() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(bottomContainer)
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false
        bottomContainer.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomContainer.topAnchor),
            
            bottomContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            bottomContainer.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    func setupBottomBarContent() {
        [priceTitleLabel, priceValueLabel, completeButton].forEach {
            bottomContainer.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            priceTitleLabel.topAnchor.constraint(equalTo: bottomContainer.topAnchor, constant: 12),
            priceTitleLabel.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor, constant: 16),
            
            priceValueLabel.topAnchor.constraint(equalTo: priceTitleLabel.bottomAnchor, constant: 2),
            priceValueLabel.leadingAnchor.constraint(equalTo: priceTitleLabel.leadingAnchor),
            
            completeButton.centerYAnchor.constraint(equalTo: bottomContainer.centerYAnchor),
            completeButton.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor, constant: -16),
            completeButton.heightAnchor.constraint(equalToConstant: 44),
            completeButton.widthAnchor.constraint(equalToConstant: 180)
        ])
    }
}

// MARK:  Button Tapped
@objc private extension BasketRootView {
    
    func basketViewDidTapCompleteButton() {
        delegate?.basketViewDidTapComplete()
    }
}
