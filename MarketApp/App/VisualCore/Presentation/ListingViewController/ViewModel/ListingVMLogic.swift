//
//  ListingVMLogic.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import Foundation

protocol IListingVMLogic {
    
    var isPaginating: Bool { get }
    var isReachLastPagePagination: Bool { get }
    var pageSize: Int { get }
    var pageNumber: Int { get }
    var searchText: String { get set }
    var products: [ProductEntity] { get set }
    
    init()
    
    // CollectionView
    func numberOfRowsInSection() -> Int
    func getCellProductModel(at index: Int) -> ProductEntity
    
    // Pagination
    mutating func fetchProductsPagination() -> Bool
    mutating func clearRequest()
    mutating func stopPagination()
}

struct ListingVMLogic: IListingVMLogic {
    
    // MARK: Definitions
    var products: [ProductEntity] = []
    
    var isPaginating = false
    var isReachLastPagePagination = false
    let pageSize = 4 // sabit
    var pageNumber = 1 // artan
    var searchText: String = ""
    
    // MARK: Initialize
    init() {
        
    }
}

// MARK: Pagination
internal extension ListingVMLogic {
    
    mutating func fetchProductsPagination() -> Bool {
        if !self.isPaginating && !self.isReachLastPagePagination  {
            self.isPaginating = true
            self.pageNumber += 1
            return true
        }
        return false
    }
    
    mutating func stopPagination() {
        self.isPaginating = false
    }
    
    mutating func clearRequest() {
        self.pageNumber = 1
        self.isPaginating = false
        self.isReachLastPagePagination = false
        self.products.removeAll()
    }
}

// MARK: TableView
extension ListingVMLogic {
    
    func numberOfRowsInSection() -> Int {
        return products.count
    }
    
    func getCellProductModel(at index: Int) -> ProductEntity {
        return products[index]
    }
}
