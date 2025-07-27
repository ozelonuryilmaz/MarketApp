//
//  BasketCell.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 27.07.2025.
//

import UIKit

protocol BasketCellOutputDelegate: AnyObject {
    
    func basketCellDidTapMinus(cart: CartEntity)
    func basketCellDidTapPlus(cart: CartEntity)
}

final class BasketCell: UITableViewCell {
    
    static let identifier = "BasketCell"
    
    // MARK: Properties
    weak var outputDelegate: BasketCellOutputDelegate?

    // MARK: Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Configure
    
    func configure(with cart: CartEntity) {
        registerEvents(cart: cart)
        
        nameLabel.text = cart.name
        priceLabel.text = "\(cart.price.formattedPrice) ₺"
        if let quantity = cart.quantity {
            quantityLabel.text = "\(quantity)"
        } else {
            quantityLabel.text = "-"
        }
    }
    
    private func registerEvents(cart: CartEntity) {
        
        minusButton.onTap { [unowned self] _ in
            self.outputDelegate?.basketCellDidTapMinus(cart: cart)
        }
        
        plusButton.onTap { [unowned self] _ in
            self.outputDelegate?.basketCellDidTapPlus(cart: cart)
        }
    }
    
    // MARK: Definitions

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .systemBlue
        return label
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.layer.cornerRadius = 4
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.layer.cornerRadius = 4
        return button
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.backgroundColor = .systemBlue
        label.textColor = .white
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var quantityStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [minusButton, quantityLabel, plusButton])
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var productStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, priceLabel])
        stack.axis = .vertical
        stack.spacing = 2
        return stack
    }()
}

// MARK: Setup
private extension BasketCell {
    
    func setupUI() {
        let container = UIStackView(arrangedSubviews: [productStack, quantityStack])
        container.axis = .horizontal
        container.alignment = .center
        container.spacing = 16
        container.distribution = .fillProportionally

        contentView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            quantityStack.widthAnchor.constraint(equalToConstant: 120),
            quantityStack.heightAnchor.constraint(equalToConstant: 44),
            quantityLabel.widthAnchor.constraint(equalToConstant: 44),
        ])
    }
}
