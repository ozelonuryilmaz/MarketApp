//
//  ListingViewModelTests.swift
//  MarketAppTests
//
//  Created by Onur Yılmaz on 27.07.2025.
//

import XCTest
import Combine
@testable import MarketApp

final class ListingViewModelTests: XCTestCase {
    
    private var viewModel: ListingViewModel!
    private var repository: MockListingRepository!
    private var coordinator: MockListingCoordinator!
    private var vmLogic: ListingVMLogic!
    private var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        repository = MockListingRepository()
        coordinator = MockListingCoordinator()
        vmLogic = ListingVMLogic()
        viewModel = ListingViewModel(repository: repository, coordinator: coordinator, vmLogic: vmLogic)
    }
    
    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
    }
    
    func test_fetctFirstProductsList_shouldResetAndFetch() {
        // Given
        let expectation = expectation(description: "Should receive reloadProductData")
        viewModel.viewState
            .dropFirst()
            .sink { state in
                if case .reloadProductData = state {
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        
        // When
        viewModel.fetctFirstProductsList()
        
        // Then
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(repository.didCallFetchProduct)
    }
    
    func test_listingProductCellDidTap_shouldCallCoordinator() {
        // Given
        let product = ProductEntity(id: "1", image: "", name: "X", price: "10", description: "desc")
        
        // When
        viewModel.listingProductCellDidTap(product: product)
        
        // Then
        XCTAssertTrue(coordinator.didCallPushDetail)
    }
    
    func test_listingViewDidTapFilter_shouldCallCoordinator() {
        // When
        viewModel.listingViewDidTapFilter()
        
        // Then
        XCTAssertTrue(coordinator.didCallPresentFilter)
    }
    
    func test_listingProductCellDidTapAddToCart_shouldTriggerRepository() {
        // Given
        let product = ProductEntity(id: "1", image: "", name: "X", price: "10", description: "desc")
        
        // When
        viewModel.listingProductCellDidTapAddToCart(product: product)
        
        // Then
        XCTAssertTrue(repository.didCallAddToCart)
    }
}
