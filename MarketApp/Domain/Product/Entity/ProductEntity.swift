//
//  File.swift
//  MarketDomain
//
//  Created by Onur Yılmaz on 25.07.2025.
//

struct ProductEntity: Codable {
    let id: String
    let image: String
    let name: String
    let price: String
    let description: String
    
    init(id: String, image: String, name: String, price: String, description: String) {
        self.id = id
        self.image = image
        self.name = name
        self.price = price
        self.description = description
    }
}
