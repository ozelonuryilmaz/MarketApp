//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 24.07.2025.
//

import Foundation
import Combine

protocol INetworkManager {
    func request<T: Decodable>(_ request: HTTPRequest) -> AnyPublisher<T, NetworkError>
}

final class NetworkManager: INetworkManager {
    init() {}

    func request<T: Decodable>(_ request: HTTPRequest) -> AnyPublisher<T, NetworkError> {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        request.headers?.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .tryMap { result -> Data in
                // TODO: Handle expected ERROR JSON responses explicitly.
                // Currently, only assumed errors defined in NetworkError are handled.
                // If the backend returns a known error payload (e.g., errorCode/message) even with status 200,
                // it should be parsed and converted into a NetworkError.apiError case or a custom error type.
                guard let httpResponse = result.response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.serverError((result.response as? HTTPURLResponse)?.statusCode ?? -1)
                }
                return result.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let urlError = error as? URLError, urlError.code == .notConnectedToInternet {
                    return .noInternet
                } else if error is DecodingError {
                    return .decodingError
                } else if let networkError = error as? NetworkError {
                    return networkError
                }
                return .unknown(error)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
