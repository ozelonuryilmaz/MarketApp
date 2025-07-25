//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 25.07.2025.
//


import Foundation
import CoreData

protocol ICartLocalDataSource: AnyObject {

    func fetchCart() -> [ProductCartDTO]
    
    @discardableResult
    func insertCartEntity(_ dto: ProductCartDTO) -> Bool
    
    @discardableResult
    func clearAllCartEntity() -> Bool
}

class CartLocalDataSource: BaseCoreDataManager<CartItemEntity>, ICartLocalDataSource {

    func fetchCart() -> [ProductCartDTO] {
        let fetchRequest: NSFetchRequest<CartItemEntity> = CartItemEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        do {
            return try managedContext.fetch(fetchRequest).map { $0.toModel() }
        } catch {
            return []
        }
    }

    @discardableResult
    func insertCartEntity(_ dto: ProductCartDTO) -> Bool {
        let cartItemEntity = CartItemEntity(context: managedContext)
        cartItemEntity.id = dto.id
        cartItemEntity.name = dto.name
        cartItemEntity.quantity = Int16(dto.quantity)
        cartItemEntity.price = dto.price
        
        return saveContext()
    }
    
    @discardableResult
    func clearAllCartEntity() -> Bool {
        return deleteAllObjectsWithBatchRequest()
    }
}
