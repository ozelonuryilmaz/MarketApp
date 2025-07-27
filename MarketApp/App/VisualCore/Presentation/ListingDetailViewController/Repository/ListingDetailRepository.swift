//
//  ListingDetailRepository.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 27.07.2025.
//

import Combine

protocol IListingDetailRepository: AnyObject {
    func addToCart(item: CartEntity) -> AnyPublisher<Bool, AppError>
}

final class ListingDetailRepository: BaseRepository, IListingDetailRepository {
    private let addToCartUseCase: IAddToCartUseCase
    
    init(addToCartUseCase: IAddToCartUseCase) {
        self.addToCartUseCase = addToCartUseCase
    }

    func addToCart(item: CartEntity) -> AnyPublisher<Bool, AppError> {
        return addToCartUseCase.execute(item)
    }
}
