import XCTest
import Combine
@testable import MarketApp

final class ProductUseCaseTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    private var mockRepository: MockProductRepository!
    private var sut: ProductUseCase!

    override func setUp() {
        super.setUp()
        cancellables = []
        mockRepository = MockProductRepository()
        sut = ProductUseCase(productRepository: mockRepository)
    }

    override func tearDown() {
        cancellables = nil
        mockRepository = nil
        sut = nil
        super.tearDown()
    }

    func test_execute_withValidResponse_shouldReturnMappedEntities() {
        // GIVEN
        let productDTOs = [
            ProductDTO(image: "image1.jpg", name: "Product A"),
            ProductDTO(image: "image2.jpg", name: "Product B")
        ]
        mockRepository.result = Just(productDTOs)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()

        let expectation = expectation(description: "Should return ProductEntity list")

        // WHEN
        sut.execute(page: 1, limit: 2)
            .sink(receiveCompletion: { _ in }, receiveValue: { entities in
                // THEN
                XCTAssertEqual(entities.count, 2)
                XCTAssertEqual(entities[0].name, "Product A")
                XCTAssertEqual(entities[1].image, "image2.jpg")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)
    }

    func test_execute_withRepositoryError_shouldPropagateError() {
        // GIVEN
        mockRepository.result = Fail(error: NetworkError.noInternet).eraseToAnyPublisher()
        let expectation = expectation(description: "Should fail with noInternet error")

        // WHEN
        sut.execute(page: 1, limit: 2)
            .sink(receiveCompletion: { completion in
                // THEN
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .noInternet)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure but got success")
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)
    }
}
