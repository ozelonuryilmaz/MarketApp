//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 25.07.2025.
//

import Foundation
import CoreData

@objc(CartItemEntity)
class CartItemEntity: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartItemEntity> {
        return NSFetchRequest<CartItemEntity>(entityName: "CartItemEntity")
    }
    
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var price: String
    @NSManaged public var quantity: Int16
}

extension CartItemEntity : Identifiable {

}

extension CartItemEntity {

    func toModel() -> ProductCartDTO {
        return ProductCartDTO(id: id, name: name, quantity: Int(quantity), price: price)
    }
}
