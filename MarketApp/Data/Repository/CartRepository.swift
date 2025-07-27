//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 25.07.2025.
//

import Foundation
import Combine

protocol ICartRepository {
    func addOrUpdateItem(_ item: ProductCartDTO) -> AnyPublisher<Bool, AppError>
    func removeItem(_ item: ProductCartDTO) -> AnyPublisher<Bool, AppError>
    func fetchCartItems() -> AnyPublisher<[ProductCartDTO], AppError>
    func clearAllCartItems() -> AnyPublisher<Bool, AppError>
}

// MARK: In the future, we can decide between using Remote or Local data here
final class CartRepository: ICartRepository {
    
    private let localDataSource: ICartLocalDataSource
    
    init(localDataSource: ICartLocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    func addOrUpdateItem(_ item: ProductCartDTO) -> AnyPublisher<Bool, AppError> {
        return localDataSource.addOrUpdateCartEntity(item)
    }
    
    func removeItem(_ item: ProductCartDTO) -> AnyPublisher<Bool, AppError> {
        return localDataSource.removeCartEntity(item)
    }
    
    func fetchCartItems() -> AnyPublisher<[ProductCartDTO], AppError> {
        return localDataSource.fetchCart()
    }
    
    func clearAllCartItems() -> AnyPublisher<Bool, AppError> {
        return localDataSource.clearAllCartEntity()
    }
}
