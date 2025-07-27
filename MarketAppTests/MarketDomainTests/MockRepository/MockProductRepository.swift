import Combine
@testable import MarketApp

final class MockProductRepository: IProductRepository {
    var result: AnyPublisher<[ProductDTO], NetworkError>!

    func fetchProducts(page: Int, limit: Int, name: String) -> AnyPublisher<[ProductDTO], NetworkError> {
        return result
    }
}
