import Combine
import Foundation
@testable import MarketApp

final class MockNetworkManager: INetworkManager {
    var result: AnyPublisher<Any, AppError>?

    func request<T>(_ request: HTTPRequest) -> AnyPublisher<T, AppError> where T : Decodable {
        guard let result = result else {
            return Fail(error: .unknown(NSError(domain: "MockNotSet", code: -999))).eraseToAnyPublisher()
        }

        return result
            .compactMap { $0 as? T }
            .eraseToAnyPublisher()
    }
}
