//
//  ListingDetailVMLogic.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 27.07.2025.
//

import Foundation

protocol IListingDetailVMLogic {
    
    var product: ProductEntity { get }
    var navigationTitle: String { get }
    
    init(data: ListingDetailParams)
    
}

struct ListingDetailVMLogic: IListingDetailVMLogic {
    
    // MARK: Definitions
    let product: ProductEntity
    
    var navigationTitle: String {
        return product.name
    }
    
    // MARK: Initialize
    init(data: ListingDetailParams) {
        product = data.product
    }
    
    // MARK: Props
}

// MARK: Props
extension ListingDetailVMLogic {
    
}
