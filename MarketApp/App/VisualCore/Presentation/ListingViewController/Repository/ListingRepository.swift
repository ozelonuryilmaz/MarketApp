//
//  ListingRepository.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import Combine

protocol IListingRepository: AnyObject {
    func fetchProducts(page: Int, limit: Int, name: String) -> AnyPublisher<[ProductEntity], AppError>
    func addToCart(item: CartEntity) -> AnyPublisher<Bool, AppError>
}

final class ListingRepository: BaseRepository, IListingRepository {
    private let fetchProductUseCase: IFetchProductUseCase
    private let addToCartUseCase: IAddToCartUseCase
    
    init(fetchProductUseCase: IFetchProductUseCase,
         addToCartUseCase: IAddToCartUseCase) {
        self.fetchProductUseCase = fetchProductUseCase
        self.addToCartUseCase = addToCartUseCase
    }
    
    func fetchProducts(page: Int, limit: Int, name: String) -> AnyPublisher<[ProductEntity], AppError> {
        return fetchProductUseCase.execute(page: page, limit: limit, name: name)
    }
    
    func addToCart(item: CartEntity) -> AnyPublisher<Bool, AppError> {
        return addToCartUseCase.execute(item)
    }
}
