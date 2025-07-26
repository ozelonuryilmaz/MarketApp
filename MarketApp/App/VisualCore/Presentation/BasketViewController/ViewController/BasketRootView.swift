//
//  BasketRootView.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

// MARK: View Interface
protocol BasketRootViewDelegate: AnyObject {
    
    //func basketViewDidTapCapture()
}

// MARK: View Implementation
final class BasketRootView: BaseRootView {
    
    weak var delegate: BasketRootViewDelegate?
    
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
        label.text = "Basket"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Devam", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(basketViewDidTapCapture), for: .touchUpInside)
        return button
    }()
}

// MARK: Setup
private extension BasketRootView {
    
    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            actionButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            actionButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

// MARK: Button Tapped
@objc private extension BasketRootView {
    
    func basketViewDidTapCapture() {
        //delegate?.basketViewDidTapCapture()
    }
}


// MARK: Setter
extension BasketRootView {
    
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
}
