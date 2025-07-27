//
//  ListingProductCell.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

protocol ListingProductCellOutputDelegate: AnyObject {
    
    func listingProductCellDidTap(product: ProductEntity)
    func listingProductCellDidTapAddToCart(product: ProductEntity)
}

final class ListingProductCell: UICollectionViewCell {
    
    static let identifier = "ListingProductCell"
    
    // MARK: Properties
    weak var outputDelegate: ListingProductCellOutputDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.08
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with product: ProductEntity) {
        registerEvents(product: product)
        
        priceLabel.text = "\(product.price.formattedPrice) ₺"
        nameLabel.text = "\(product.name)"
    }
    
    private func registerEvents(product: ProductEntity) {
        
        contentView.onTap { [unowned self] _ in
            self.outputDelegate?.listingProductCellDidTap(product: product)
        }
        
        cartButton.onTap { [unowned self] _ in
            self.outputDelegate?.listingProductCellDidTapAddToCart(product: product)
        }
    }
    
    // MARK: Definitions
    
    private let imageView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private let cartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add to Cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 6
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()
}

// MARK: Setup
private extension ListingProductCell {
    
    func setupUI() {
        [imageView, starImageView, priceLabel, nameLabel, cartButton].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            starImageView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 4),
            starImageView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -4),
            starImageView.widthAnchor.constraint(equalToConstant: 20),
            starImageView.heightAnchor.constraint(equalToConstant: 20),
            
            priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            nameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            cartButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            cartButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            cartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            cartButton.heightAnchor.constraint(equalToConstant: 36),
            cartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}

