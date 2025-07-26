//
//  ListingRootView.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

// MARK: View Interface
protocol ListingRootViewDelegate: AnyObject {
    
    //func listingPhotoTopViewDidTapCapture()
}

protocol IListingRootView: AnyObject {
    func setTitle(_ text: String)
}

// MARK: View Implementation
final class ListingRootView: BaseRootView {
    
    weak var delegate: ListingRootViewDelegate?
    
    // MARK: Init
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupUI()
    }
    
    // MARK: Definitions
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .label
        label.textAlignment = .center
        label.text = "Listing"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Devam", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(listingPhotoTopViewDidTapCapture), for: .touchUpInside)
        return button
    }()
}

// MARK: Setup
private extension ListingRootView {
    
    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        addSubview(actionButton)
        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            actionButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

// MARK:  Button Tapped
@objc private extension ListingRootView {
    
    func listingPhotoTopViewDidTapCapture() {
        //delegate?.listingPhotoTopViewDidTapCapture()
    }
}


// MARK: IListingRootView
extension ListingRootView: IListingRootView {
    
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
}
