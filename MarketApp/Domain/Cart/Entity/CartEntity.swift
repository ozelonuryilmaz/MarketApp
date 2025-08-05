//
//  File.swift
//  MarketDomain
//
//  Created by Onur Yılmaz on 25.07.2025.
//

import Foundation

// TODO: Make sure changes in any layer are reflected across all layers.
// TODO: Do not use Entity in the App layer.
struct CartEntity: Codable {
    let id: String
    let name: String
    let quantity: Int?
    let price: String
    
    init(id: String, name: String, price: String) {
        self.id = id
        self.name = name
        self.price = price
        self.quantity = nil
    }

    init(id: String, name: String, quantity: Int?, price: String) {
        self.id = id
        self.name = name
        self.price = price
        self.quantity = quantity
    }
}
