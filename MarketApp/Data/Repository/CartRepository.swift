//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 25.07.2025.
//

import Foundation
import Combine

protocol ICartRepository {
    func saveCartItem(_ item: ProductCartDTO) -> AnyPublisher<Bool, Error>
    func fetchCartItems() -> AnyPublisher<[ProductCartDTO], Error>
    func clearAllCartItems() -> AnyPublisher<Bool, Error>
}

// MARK: In the future, we can decide between using Remote or Local data here
final class CartRepository: ICartRepository {
    private let localDataSource: ICartLocalDataSource

    init(localDataSource: ICartLocalDataSource) {
        self.localDataSource = localDataSource
    }

    func saveCartItem(_ item: ProductCartDTO) -> AnyPublisher<Bool, Error> {
        return localDataSource.insertCartEntity(item)
    }

    func fetchCartItems() -> AnyPublisher<[ProductCartDTO], Error> {
        return localDataSource.fetchCart()
    }

    func clearAllCartItems() -> AnyPublisher<Bool, Error> {
        return localDataSource.clearAllCartEntity()
    }
}
