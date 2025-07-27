//
//  ListingVMLogicTests.swift
//  MarketAppTests
//
//  Created by Onur Yılmaz on 27.07.2025.
//

import XCTest
@testable import MarketApp

final class ListingVMLogicTests: XCTestCase {
    
    var logic: ListingVMLogic!
    
    override func setUp() {
        super.setUp()
        logic = ListingVMLogic()
    }
    
    override func tearDown() {
        logic = nil
        super.tearDown()
    }
    
    // MARK: - Pagination
    
    func test_fetchProductsPagination_shouldStartPagination() {
        // Given
        XCTAssertFalse(logic.isPaginating)
        
        // When
        let shouldFetch = logic.fetchProductsPagination()
        
        // Then
        XCTAssertTrue(shouldFetch)
        XCTAssertTrue(logic.isPaginating)
        XCTAssertEqual(logic.pageNumber, 2)
    }
    
    func test_fetchProductsPagination_shouldNotStartWhenAlreadyPaginating() {
        // Given
        logic.isPaginating = true
        
        // When
        let shouldFetch = logic.fetchProductsPagination()
        
        // Then
        XCTAssertFalse(shouldFetch)
        XCTAssertEqual(logic.pageNumber, 1)
    }
    
    func test_fetchProductsPagination_shouldNotStartWhenReachLastPage() {
        // Given
        logic.isReachLastPagePagination = true
        
        // When
        let shouldFetch = logic.fetchProductsPagination()
        
        // Then
        XCTAssertFalse(shouldFetch)
    }
    
    func test_stopPagination_shouldDisablePagination() {
        // Given
        logic.isPaginating = true
        
        // When
        logic.stopPagination()
        
        // Then
        XCTAssertFalse(logic.isPaginating)
    }
    
    // MARK: - Reset
    
    func test_clearRequest_shouldResetAllValues() {
        // Given
        logic.isPaginating = true
        logic.pageNumber = 3
        logic.isReachLastPagePagination = true
        logic.addResponse([.mock1, .mock2])
        
        // When
        logic.clearRequest()
        
        // Then
        XCTAssertEqual(logic.pageNumber, 1)
        XCTAssertFalse(logic.isPaginating)
        XCTAssertFalse(logic.isReachLastPagePagination)
        XCTAssertEqual(logic.numberOfRowsInSection(), 0)
    }
    
    // MARK: - Data Management
    
    func test_addResponse_shouldAppendProducts() {
        // Given
        XCTAssertEqual(logic.numberOfRowsInSection(), 0)
        
        // When
        logic.addResponse([.mock1, .mock2])
        
        // Then
        XCTAssertEqual(logic.numberOfRowsInSection(), 2)
    }
    
    func test_reachLastPagePagination_shouldSetTrueIfLessThanPageSize() {
        // Given
        let response = [ProductEntity(id: "1", image: "", name: "A", price: "1.0", description: "dec")]
        
        // When
        logic.reachLastPagePagination(products: response)
        
        // Then
        XCTAssertTrue(logic.isReachLastPagePagination)
    }
    
    func test_reachLastPagePagination_shouldSetFalseIfEqualOrMoreThanPageSize() {
        // Given
        let response = Array(repeating: ProductEntity(id: "1", image: "", name: "X", price: "2.0", description: "dec"), count: 4)
        
        // When
        logic.reachLastPagePagination(products: response)
        
        // Then
        XCTAssertFalse(logic.isReachLastPagePagination)
    }
    
    // MARK: - CollectionView
    
    func test_getCellProductModel_shouldReturnCorrectItem() {
        // Given
        logic.addResponse([.mock1])
        
        // When
        let item = logic.getCellProductModel(at: 0)
        
        // Then
        XCTAssertEqual(item?.id, "mock1")
    }
    
    func test_getCellProductModel_shouldReturnNilWhenOutOfBounds() {
        // Given
        logic.addResponse([.mock1])
        
        // When
        let item = logic.getCellProductModel(at: 3)
        
        // Then
        XCTAssertNil(item)
    }
}

extension ProductEntity {
    static let mock1 = ProductEntity(id: "mock1", image: "", name: "Test1", price: "1.0", description: "dec")
    static let mock2 = ProductEntity(id: "mock2", image: "", name: "Test2", price: "2.0", description: "dec")
}
