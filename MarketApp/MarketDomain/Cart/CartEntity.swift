//
//  File.swift
//  MarketDomain
//
//  Created by Onur Yılmaz on 25.07.2025.
//

import Foundation

struct CartEntity: Equatable {
    let id: String
    let name: String
    let quantity: Int
    let price: String

    init(id: String, name: String, quantity: Int, price: String) {
        self.id = id
        self.name = name
        self.price = price
        self.quantity = quantity
    }
}
