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
    
    mutating func increaseQuantity(for item: CartEntity)
    mutating func decreaseQuantity(for item: CartEntity)
    
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

// MARK: Quantity Update
// NOTE: Quantity is updated based on the service response, so Race-Conditions won't occur.
// However, if logic changes and parallel access happens, make sure the structure is thread-safe.
extension BasketVMLogic {
    
    mutating func increaseQuantity(for item: CartEntity) {
        guard let index = carts.firstIndex(where: { $0.id == item.id }) else { return }
        
        let currentQuantity = carts[index].quantity ?? 0
        carts[index] = CartEntity(
            id: item.id,
            name: item.name,
            quantity: currentQuantity + 1,
            price: item.price
        )
    }
    
    mutating func decreaseQuantity(for item: CartEntity) {
        guard let index = carts.firstIndex(where: { $0.id == item.id }) else { return }
        
        let currentQuantity = carts[index].quantity ?? 0
        
        if currentQuantity <= 1 {
            carts.remove(at: index)
        } else {
            carts[index] = CartEntity(
                id: item.id,
                name: item.name,
                quantity: currentQuantity - 1,
                price: item.price
            )
        }
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
