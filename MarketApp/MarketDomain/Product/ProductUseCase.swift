//
//  File.swift
//  MarketDomain
//
//  Created by Onur Yılmaz on 25.07.2025.
//

import Combine

protocol IProductUseCase {
    func execute(page: Int, limit: Int) -> AnyPublisher<[ProductEntity], NetworkError>
}

final class ProductUseCase: IProductUseCase {
    private let productRepository: IProductRepository

    init(productRepository: IProductRepository) {
        self.productRepository = productRepository
    }

    func execute(page: Int, limit: Int) -> AnyPublisher<[ProductEntity], NetworkError> {
        productRepository.fetchProducts(page: page, limit: limit)
            .map { $0.map { ProductEntity(image: $0.image, name: $0.name) } }
            .eraseToAnyPublisher()
    }
}
