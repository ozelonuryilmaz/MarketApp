//
//  MockListingRepository.swift
//  MarketAppTests
//
//  Created by Onur Yılmaz on 27.07.2025.
//

import Combine
@testable import MarketApp

final class MockListingRepository: IListingRepository {
    
    var didCallFetchProduct = false
    var didCallAddToCart = false
    
    func fetchProducts(page: Int, limit: Int, name: String) -> AnyPublisher<[ProductEntity], AppError> {
        didCallFetchProduct = true
        return Just([ProductEntity(id: "1", image: "", name: "Mock", price: "5", description: "desc")])
            .setFailureType(to: AppError.self)
            .eraseToAnyPublisher()
    }
    
    func addToCart(item: CartEntity) -> AnyPublisher<Bool, AppError> {
        didCallAddToCart = true
        return Just(true)
            .setFailureType(to: AppError.self)
            .eraseToAnyPublisher()
    }
}
