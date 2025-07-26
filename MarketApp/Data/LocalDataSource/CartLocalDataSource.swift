//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 25.07.2025.
//


import Combine
import CoreData

protocol ICartLocalDataSource: AnyObject {
    func fetchCart() -> AnyPublisher<[ProductCartDTO], Error>
    func insertCartEntity(_ dto: ProductCartDTO) -> AnyPublisher<Bool, Error>
    func clearAllCartEntity() -> AnyPublisher<Bool, Error>
}

final class CartLocalDataSource: BaseCoreDataManager<CartItemEntity>, ICartLocalDataSource {

    func fetchCart() -> AnyPublisher<[ProductCartDTO], Error> {
        Future<[ProductCartDTO], Error> { [weak self] promise in
            guard let self else {
                return promise(.failure(NSError(domain: "self is nil", code: -1)))
            }

            let fetchRequest: NSFetchRequest<CartItemEntity> = CartItemEntity.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

            do {
                let result = try managedContext.fetch(fetchRequest).map { $0.toModel() }
                promise(.success(result))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }

    func insertCartEntity(_ dto: ProductCartDTO) -> AnyPublisher<Bool, Error> {
        Future<Bool, Error> { [weak self] promise in
            guard let self else {
                return promise(.failure(NSError(domain: "self is nil", code: -1)))
            }

            let cartItemEntity = CartItemEntity(context: managedContext)
            cartItemEntity.id = dto.id
            cartItemEntity.name = dto.name
            cartItemEntity.quantity = Int16(dto.quantity)
            cartItemEntity.price = dto.price

            let result = saveContext()
            if result {
                promise(.success(true))
            } else {
                promise(.failure(NSError(domain: "Insert failed", code: -2)))
            }
        }.eraseToAnyPublisher()
    }

    func clearAllCartEntity() -> AnyPublisher<Bool, Error> {
        Future<Bool, Error> { [weak self] promise in
            guard let self else {
                return promise(.failure(NSError(domain: "self is nil", code: -1)))
            }

            let result = deleteAllObjectsWithBatchRequest()
            if result {
                promise(.success(true))
            } else {
                promise(.failure(NSError(domain: "Delete failed", code: -3)))
            }
        }.eraseToAnyPublisher()
    }
}
