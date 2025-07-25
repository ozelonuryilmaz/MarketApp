//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 25.07.2025.
//

import Foundation
import Combine

protocol ICartRepository {
    func saveCartItem(_ item: ProductCartDTO) -> Bool
    func fetchCartItems() -> [ProductCartDTO]
}

// MARK: In the future, we can decide between using Remote or Local data here
final class CartRepository: ICartRepository {
    private let localDataSource: ICartLocalDataSource

    init(localDataSource: ICartLocalDataSource) {
        self.localDataSource = localDataSource
    }

    func saveCartItem(_ item: ProductCartDTO) -> Bool {
        localDataSource.insertCartEntity(item)
    }

    func fetchCartItems() -> [ProductCartDTO] {
        localDataSource.fetchCart()
    }
}
