//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 25.07.2025.
//

import Combine
import CoreData

protocol ICartLocalDataSource: AnyObject {
    func fetchCart() -> AnyPublisher<[ProductCartDTO], AppError>
    func addOrUpdateCartEntity(_ dto: ProductCartDTO) -> AnyPublisher<Bool, AppError>
    func removeCartEntity(_ dto: ProductCartDTO) -> AnyPublisher<Bool, AppError>
    func clearAllCartEntity() -> AnyPublisher<Bool, AppError>
}

final class CartLocalDataSource: BaseCoreDataManager<CartItemEntity>, ICartLocalDataSource {
    
    // TODO: When user starts a queue for basket actions in Listing Tab,
    // make sure it completes before switching to Basket Tab.
    // Otherwise, a new queue may be created and cause data inconsistency.
    // Ensure operations run through a single instance to avoid conflicts.
    private let queue = DispatchQueue(label: "com.marketdata.cartQueue", attributes: .concurrent)
    
    func fetchCart() -> AnyPublisher<[ProductCartDTO], AppError> {
        Future { [weak self] promise in
            self?.queue.async {
                guard let self else {
                    return promise(.failure(.localUnknown(NSError(domain: "self is nil", code: -1))))
                }
                
                let fetchRequest: NSFetchRequest<CartItemEntity> = CartItemEntity.fetchRequest()
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
                
                do {
                    let result = try self.managedContext.fetch(fetchRequest).map { $0.toModel() }
                    promise(.success(result))
                } catch {
                    promise(.failure(.fetchFailed))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func addOrUpdateCartEntity(_ dto: ProductCartDTO) -> AnyPublisher<Bool, AppError> {
        Future { [weak self] promise in
            self?.queue.async(flags: .barrier) {
                guard let self else {
                    return promise(.failure(.localUnknown(NSError(domain: "self is nil", code: -1))))
                }
                
                let fetchRequest: NSFetchRequest<CartItemEntity> = CartItemEntity.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %@", dto.id)
                
                do {
                    let results = try self.managedContext.fetch(fetchRequest)
                    
                    if let existing = results.first {
                        existing.quantity += 1
                    } else {
                        let newItem = CartItemEntity(context: self.managedContext)
                        newItem.id = dto.id
                        newItem.name = dto.name
                        newItem.price = dto.price
                        newItem.quantity = 1
                    }
                    
                    let saved = self.saveContext()
                    saved ? promise(.success(true)) : promise(.failure(.saveFailed))
                } catch {
                    promise(.failure(.saveFailed))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func removeCartEntity(_ dto: ProductCartDTO) -> AnyPublisher<Bool, AppError> {
        Future { [weak self] promise in
            self?.queue.async(flags: .barrier) {
                guard let self else {
                    return promise(.failure(.localUnknown(NSError(domain: "self is nil", code: -1))))
                }
                
                let fetchRequest: NSFetchRequest<CartItemEntity> = CartItemEntity.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %@", dto.id)
                
                do {
                    let results = try self.managedContext.fetch(fetchRequest)
                    
                    guard let existing = results.first else {
                        return promise(.success(false)) // zaten yok
                    }
                    
                    if existing.quantity > 1 {
                        existing.quantity -= 1
                    } else {
                        self.managedContext.delete(existing)
                    }
                    
                    let saved = self.saveContext()
                    saved ? promise(.success(true)) : promise(.failure(.saveFailed))
                } catch {
                    promise(.failure(.saveFailed))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func clearAllCartEntity() -> AnyPublisher<Bool, AppError> {
        Future { [weak self] promise in
            self?.queue.async(flags: .barrier) {
                guard let self else {
                    return promise(.failure(.localUnknown(NSError(domain: "self is nil", code: -1))))
                }
                
                let result = self.deleteAllObjectsWithBatchRequest()
                result ? promise(.success(true)) : promise(.failure(.saveFailed))
            }
        }.eraseToAnyPublisher()
    }
}
