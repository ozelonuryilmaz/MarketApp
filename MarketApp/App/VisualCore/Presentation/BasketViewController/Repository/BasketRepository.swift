//
//  BasketRepository.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import Combine

protocol IBasketRepository: AnyObject {
    
    func addToCart(item: CartEntity) -> AnyPublisher<Bool, AppError>
    func removeItem(item: CartEntity) -> AnyPublisher<Bool, AppError>
    func fetchCartItems() -> AnyPublisher<[CartEntity], AppError>
}

final class BasketRepository: BaseRepository, IBasketRepository {
    private let addToCartUseCase: IAddToCartUseCase
    private let removeFromCartUseCase: IRemoveFromCartUseCase
    private let fetchCartItemsUseCase: IFetchCartItemsUseCase
    
    init(addToCartUseCase: IAddToCartUseCase,
         removeFromCartUseCase: IRemoveFromCartUseCase,
         fetchCartItemsUseCase: IFetchCartItemsUseCase) {
        self.addToCartUseCase = addToCartUseCase
        self.removeFromCartUseCase = removeFromCartUseCase
        self.fetchCartItemsUseCase = fetchCartItemsUseCase
    }

    func addToCart(item: CartEntity) -> AnyPublisher<Bool, AppError> {
        return addToCartUseCase.execute(item)
    }
    
    func removeItem(item: CartEntity) -> AnyPublisher<Bool, AppError> {
        return removeFromCartUseCase.execute(item)
    }
    
    func fetchCartItems() -> AnyPublisher<[CartEntity], AppError> {
        return fetchCartItemsUseCase.execute()
    }
}
