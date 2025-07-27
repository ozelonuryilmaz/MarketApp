//
//  RemoveFromCartUseCase.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 27.07.2025.
//

import Combine

protocol IRemoveFromCartUseCase {
    func execute(_ item: CartEntity) -> AnyPublisher<Bool, AppError>
}

struct RemoveFromCartUseCase: IRemoveFromCartUseCase {
    private let repository: ICartRepository

    init(repository: ICartRepository) {
        self.repository = repository
    }

    func execute(_ item: CartEntity) -> AnyPublisher<Bool, AppError> {
        let dto = ProductCartDTO(id: item.id, name: item.name, price: item.price)
        return repository.removeItem(dto)
    }
}
