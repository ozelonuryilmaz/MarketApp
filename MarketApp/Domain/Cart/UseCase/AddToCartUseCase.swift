//
//  AddToCartUseCase.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 25.07.2025.
//

import Combine

protocol IAddToCartUseCase {
    func execute(_ item: CartEntity) -> AnyPublisher<Bool, Error>
}

final class AddToCartUseCase: IAddToCartUseCase {
    private let repository: ICartRepository

    init(repository: ICartRepository) {
        self.repository = repository
    }

    func execute(_ item: CartEntity) -> AnyPublisher<Bool, Error> {
        let dto = ProductCartDTO(id: item.id, name: item.name, quantity: item.quantity, price: item.price)
        return repository.saveCartItem(dto)
    }
}
