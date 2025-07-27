import Combine
@testable import MarketApp

final class MockProductRepository: IProductRepository {
    var result: AnyPublisher<[ProductDTO], AppError>!

    func fetchProducts(page: Int, limit: Int, name: String) -> AnyPublisher<[ProductDTO], AppError> {
        return result
    }
}
