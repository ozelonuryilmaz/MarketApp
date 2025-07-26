//
//  FetchCartItemsUseCase.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 25.07.2025.
//

import Combine

protocol IFetchCartItemsUseCase {
    func execute() -> AnyPublisher<[CartEntity], Error>
}

struct FetchCartItemsUseCase: IFetchCartItemsUseCase {
    private let repository: ICartRepository

    init(repository: ICartRepository) {
        self.repository = repository
    }

    func execute() -> AnyPublisher<[CartEntity], Error> {
        repository.fetchCartItems()
            .map { dtos in
                dtos.map { dto in
                    CartEntity(id: dto.id, name: dto.name, quantity: dto.quantity, price: dto.price)
                }
            }
            .eraseToAnyPublisher()
    }
}
