//
//  AddToCartUseCase.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 25.07.2025.
//

protocol IAddToCartUseCase {
    func execute(_ item: CartEntity) -> Bool
}

final class AddToCartUseCase: IAddToCartUseCase {
    private let repository: ICartRepository

    init(repository: ICartRepository) {
        self.repository = repository
    }

    func execute(_ item: CartEntity) -> Bool {
        let dto = ProductCartDTO(id: item.id, name: item.name, quantity: item.quantity, price: item.price)
        return repository.saveCartItem(dto)
    }
}


