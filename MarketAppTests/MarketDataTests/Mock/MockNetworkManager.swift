import Combine
import Foundation
@testable import MarketApp

final class MockNetworkManager: INetworkManager {
    var result: AnyPublisher<Any, NetworkError>?

    func request<T>(_ request: HTTPRequest) -> AnyPublisher<T, NetworkError> where T : Decodable {
        guard let result = result else {
            return Fail(error: .unknown(NSError(domain: "MockNotSet", code: -999))).eraseToAnyPublisher()
        }

        return result
            .compactMap { $0 as? T }
            .eraseToAnyPublisher()
    }
}
