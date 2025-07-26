//
//  SearchTextField.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import UIKit

final class SearchTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setup() {
        placeholder = "Search"
        backgroundColor = UIColor.systemGray6
        layer.cornerRadius = 12
        layer.borderWidth = 0
        font = .systemFont(ofSize: 18, weight: .medium)
        textColor = .darkGray
        clearButtonMode = .whileEditing
        autocorrectionType = .no
        borderStyle = .none
        
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        imageView.center = container.center
        container.addSubview(imageView)
        
        leftView = container
        leftViewMode = .always
    }
}

