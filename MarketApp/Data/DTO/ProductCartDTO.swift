//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 25.07.2025.
//

struct ProductCartDTO {
    let id: String
    let name: String
    let quantity: Int
    let price: String
    
    init(id: String, name: String, quantity: Int, price: String) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.price = price
    }
}
