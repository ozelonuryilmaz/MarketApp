//
//  File.swift
//  MarketDomain
//
//  Created by Onur Yılmaz on 25.07.2025.
//

struct ProductEntity: Codable {
    let image: String
    let name: String
    let price: String
    
    init(image: String, name: String, price: String) {
        self.image = image
        self.name = name
        self.price = price
    }
}
