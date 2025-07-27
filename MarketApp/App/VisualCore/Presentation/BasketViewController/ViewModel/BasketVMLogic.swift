//
//  BasketVMLogic.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import Foundation

protocol IBasketVMLogic {
    
    init()
    
    // TableView
    func numberOfRowsInSection() -> Int
    func getCellCartModel(at index: Int) -> CartEntity?
}

struct BasketVMLogic: IBasketVMLogic {
    
    // MARK: Definitions
    
    // MARK: Initialize
    init() {
        
    }
    
    // MARK: Props
}

// MARK: Props
extension BasketVMLogic {
    
}

// MARK: TableView
extension BasketVMLogic {
    
    func numberOfRowsInSection() -> Int {
        return 5
    }
    
    func getCellCartModel(at index: Int) -> CartEntity? {
        return CartEntity(id: "1", name: "Apple", quantity: 1, price: "1000,23")
    }
}
