//
//  ListingRepository.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import Combine

protocol IListingRepository: AnyObject {
    
    func fetchProducts(page: Int, limit: Int, name: String) -> AnyPublisher<[ProductEntity], NetworkError>
}

final class ListingRepository: BaseRepository, IListingRepository {
    private let productUseCase: IProductUseCase
    
    init(productUseCase: IProductUseCase) {
        self.productUseCase = productUseCase
    }
    
    func fetchProducts(page: Int, limit: Int, name: String) -> AnyPublisher<[ProductEntity], NetworkError> {
        return productUseCase.execute(page: page, limit: limit, name: name)
    }
}
