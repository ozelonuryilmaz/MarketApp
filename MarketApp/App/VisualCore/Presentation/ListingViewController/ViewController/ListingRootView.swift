//
//  ListingRootView.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

// MARK: View Interface
protocol ListingRootViewDelegate: AnyObject {
    func listingViewDidTapFilter()
    func listingViewSearchTextDidChange(_ text: String)
}

// TODO: Adjust layout for pixel-perfect alignment
final class ListingRootView: BaseRootView {
    
    weak var delegate: ListingRootViewDelegate?
    
    // MARK: Init
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupUI()
    }
    
    func setDataSource(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
    }
    
    func reloadProductData() {
        collectionView.reloadData()
    }
    
    // MARK: Definitions
    
    // TODO: Add 3 UIViews inside ScrollView with proper priority to auto-expand.
    // Include search, filter, and collectionView in these views.
    // This setup will allow search and filter to hide during scrolling
    
    private lazy var searchTextField: SearchTextField = {
        let textfield = SearchTextField()
        textfield.addTarget(self, action: #selector(listingViewSearchTextDidChange(_:)), for: .editingChanged)
        return textfield
    }()
    
    // TODO: Avoid unsafe and inefficient use of 'lazy'.
    // Use 'let' for properties that must always be visible on the screen.
    // TODO: Make sure all operations go through a single instance to prevent conflicts.
    
    private lazy var filterLabel: UILabel = {
        let label = UILabel()
        label.text = "Filters:"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Filter", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.backgroundColor = UIColor.systemGray4
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.layer.cornerRadius = 0
        button.contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
        button.addTarget(self, action: #selector(listingViewDidTapFilter), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 8
        
        let totalSpacing: CGFloat = 16 * 3
        let width = (UIScreen.main.bounds.width - totalSpacing) / 2
        layout.itemSize = CGSize(width: width, height: width + 100)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16) // Kenar boşlukları
        cv.keyboardDismissMode = .onDrag
        cv.backgroundColor = .white
        cv.register(ListingProductCell.self, forCellWithReuseIdentifier: ListingProductCell.identifier)
        return cv
    }()
}

// MARK: Setup
private extension ListingRootView {
    
    func setupUI() {
        [searchTextField, filterLabel, filterButton, collectionView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),
            
            filterLabel.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            filterLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            filterButton.centerYAnchor.constraint(equalTo: filterLabel.centerYAnchor),
            filterButton.widthAnchor.constraint(equalToConstant: 158),
            filterButton.heightAnchor.constraint(equalToConstant: 36),
            filterButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: filterLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK:  Button Tapped
@objc private extension ListingRootView {
    
    func listingViewDidTapFilter() {
        delegate?.listingViewDidTapFilter()
    }
    
    func listingViewSearchTextDidChange(_ textField: UITextField) {
        delegate?.listingViewSearchTextDidChange(textField.text ?? "")
    }
}
