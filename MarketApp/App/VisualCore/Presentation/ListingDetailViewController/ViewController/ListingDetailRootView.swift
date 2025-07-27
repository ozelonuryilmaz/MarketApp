//
//  ListingDetailRootView.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 27.07.2025.
//

import UIKit

protocol ListingDetailRootViewDelegate: AnyObject {
    
    func listingDetailViewDidTapAddToCart()
}

// TODO: Adjust layout for pixel-perfect alignment
final class ListingDetailRootView: BaseRootView {
    
    weak var delegate: ListingDetailRootViewDelegate?
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Configure
    
    func configure(_ product: ProductEntity) {
        titleLabel.text = product.name
        descriptionLabel.text = product.description
        priceValueLabel.text = "\(product.price.formattedPrice) ₺"
    }
    
    // MARK: Definitions
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = nil
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray5
        return imageView
    }()
    
    private lazy var favoriteIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    // TODO: Extract bottomContainer from ListingDetailRootView and BasketRootView into a shared component
    private let bottomContainer = UIView()
    
    private lazy var priceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Price:"
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
    
    lazy var addToCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add to Cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .heavy)
        button.addTarget(self, action: #selector(listingDetailViewDidTapAddToCart), for: .touchUpInside)
        return button
    }()

}

// MARK: Setup
private extension ListingDetailRootView {
    
    func setupUI() {
        setupContentViews()
        setupScrollContent()
        setupBottomBarContent()
    }
    
    func setupContentViews() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(bottomContainer)
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false
        bottomContainer.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomContainer.topAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            bottomContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            bottomContainer.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    func setupScrollContent() {
        [productImageView, favoriteIcon, titleLabel, descriptionLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            productImageView.heightAnchor.constraint(equalToConstant: 200),
            
            favoriteIcon.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 8),
            favoriteIcon.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: -8),
            favoriteIcon.widthAnchor.constraint(equalToConstant: 24),
            favoriteIcon.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
    
    func setupBottomBarContent() {
        [priceTitleLabel, priceValueLabel, addToCartButton].forEach {
            bottomContainer.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            priceTitleLabel.topAnchor.constraint(equalTo: bottomContainer.topAnchor, constant: 12),
            priceTitleLabel.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor, constant: 16),
            
            priceValueLabel.topAnchor.constraint(equalTo: priceTitleLabel.bottomAnchor, constant: 2),
            priceValueLabel.leadingAnchor.constraint(equalTo: priceTitleLabel.leadingAnchor),
            
            addToCartButton.centerYAnchor.constraint(equalTo: bottomContainer.centerYAnchor),
            addToCartButton.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor, constant: -16),
            addToCartButton.heightAnchor.constraint(equalToConstant: 44),
            addToCartButton.widthAnchor.constraint(equalToConstant: 180)
        ])
    }
}

// MARK:  Button Tapped
@objc private extension ListingDetailRootView {
    
    func listingDetailViewDidTapAddToCart() {
        delegate?.listingDetailViewDidTapAddToCart()
    }
}
