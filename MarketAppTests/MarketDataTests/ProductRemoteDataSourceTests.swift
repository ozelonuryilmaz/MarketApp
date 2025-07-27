import XCTest
import Combine
@testable import MarketApp

final class ProductRemoteDataSourceTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    private var sut: ProductRemoteDataSource!
    private var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        cancellables = []
        mockNetworkManager = MockNetworkManager()
        sut = ProductRemoteDataSource(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        cancellables = nil
        sut = nil
        mockNetworkManager = nil
        super.tearDown()
    }

    func test_fetchProducts_successfullyReturnsProducts() {
        // GIVEN
        let expectedProducts = [
            ProductDTO(image: "image1.png", name: "Product 1", price: "1"),
            ProductDTO(image: "image2.png", name: "Product 2", price: "2")
        ]
        mockNetworkManager.result = Just(expectedProducts)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
        
        let expectation = self.expectation(description: "Should return product list")
        
        // WHEN
        sut.fetchProducts(page: 1, limit: 2, name: "")
            .sink(receiveCompletion: { _ in },
                  receiveValue: { products in
                // THEN
                XCTAssertEqual(products.count, expectedProducts.count)
                XCTAssertEqual(products.first?.name, "Product 1")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_fetchProducts_networkManagerReturnsError_shouldPropagateError() {
        // GIVEN
        mockNetworkManager.result = Fail(error: NetworkError.noInternet).eraseToAnyPublisher()
        
        // WHEN
        let expectation = expectation(description: "Should return noInternet error")
        
        sut.fetchProducts(page: 1, limit: 10, name: "")
            .sink(receiveCompletion: { completion in
                // THEN
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .noInternet)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
