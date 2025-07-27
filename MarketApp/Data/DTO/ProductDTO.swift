//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 24.07.2025.
//

struct ProductDTO: Decodable {
    let id: String
    let image: String
    let name: String
    let price: String
    let description: String
    
    init(id: String, image: String, name: String, price: String, description: String) {
        self.id = id
        self.name = name
        self.image = image
        self.price = price
        self.description = description
    }
}
