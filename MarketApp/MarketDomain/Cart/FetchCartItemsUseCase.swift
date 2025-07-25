//
//  FetchCartItemsUseCase.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 25.07.2025.
//

protocol IFetchCartItemsUseCase {
    func execute() -> [CartEntity]
}

final class FetchCartItemsUseCase: IFetchCartItemsUseCase {
    private let repository: ICartRepository

    init(repository: ICartRepository) {
        self.repository = repository
    }

    func execute() -> [CartEntity] {
        return repository.fetchCartItems().map { dto in
            return CartEntity(id: dto.id, name: dto.name, quantity: dto.quantity, price: dto.price)
        }
    }
}
