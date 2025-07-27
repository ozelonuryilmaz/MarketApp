//
//  ClearCartUseCase.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 27.07.2025.
//

import Combine

protocol IClearAllCartUseCase {
    func execute() -> AnyPublisher<Bool, AppError>
}

struct ClearAllCartUseCase: IClearAllCartUseCase {
    private let repository: ICartRepository
    
    init(repository: ICartRepository) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<Bool, AppError> {
        return repository.clearAllCartItems()
    }
}
