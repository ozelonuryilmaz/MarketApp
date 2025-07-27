//
//  File.swift
//  MarketDomain
//
//  Created by Onur Yılmaz on 25.07.2025.
//

import Combine

protocol IProductUseCase {
    func execute(page: Int, limit: Int, name: String) -> AnyPublisher<[ProductEntity], NetworkError>
}

struct ProductUseCase: IProductUseCase {
    private let productRepository: IProductRepository

    init(productRepository: IProductRepository) {
        self.productRepository = productRepository
    }

    func execute(page: Int, limit: Int, name: String) -> AnyPublisher<[ProductEntity], NetworkError> {
        productRepository.fetchProducts(page: page, limit: limit, name: name)
            .map { $0.map { ProductEntity(id: $0.id, image: $0.image, name: $0.name, price: $0.price, description: $0.description) } }
            .eraseToAnyPublisher()
    }
}
