//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 24.07.2025.
//

import Combine

protocol IProductRepository {
    func fetchProducts(page: Int, limit: Int) -> AnyPublisher<[ProductDTO], NetworkError>
}

// MARK: In the future, we can decide between using Remote or Local data here
final class ProductRepository: IProductRepository {
    private let remoteDataSource: IProductRemoteDataSource

    init(remoteDataSource: IProductRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func fetchProducts(page: Int, limit: Int) -> AnyPublisher<[ProductDTO], NetworkError> {
        return remoteDataSource.fetchProducts(page: page, limit: limit)
    }
}
