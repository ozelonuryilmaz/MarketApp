//
//  BasketVMLogic.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import Foundation

protocol IBasketVMLogic {
    
    var totalPrice: String { get }
    
    init()
    
    mutating func setResponse(_ response: [CartEntity])
    
    // TableView
    func numberOfRowsInSection() -> Int
    func getCellCartModel(at index: Int) -> CartEntity?
}

struct BasketVMLogic: IBasketVMLogic {
    
    // MARK: Definitions
    private var carts: [CartEntity] = []
    
    var totalPrice: String {
        return "\(carts.calculateTotalPrice())".formattedPrice + " ₺"
    }
    
    // MARK: Initialize
    init() {
        
    }
    
    // MARK: Props
    
}

// MARK: Setter
extension BasketVMLogic {
    
    mutating func setResponse(_ response: [CartEntity]) {
        self.carts = response
    }
}

// MARK: TableView
extension BasketVMLogic {
    
    func numberOfRowsInSection() -> Int {
        return carts.count
    }
    
    func getCellCartModel(at index: Int) -> CartEntity? {
        guard carts.indices.contains(index) else { return nil }
        return carts[index]
    }
}

fileprivate extension Array where Element == CartEntity {
    func calculateTotalPrice() -> Double {
        self.reduce(0.0) { total, item in
            let quantity = Double(item.quantity ?? 0)
            let price = Double(item.price) ?? 0.0
            return total + (price * quantity)
        }
    }
}
