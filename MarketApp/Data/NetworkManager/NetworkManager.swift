//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 24.07.2025.
//

import Foundation
import Combine

protocol INetworkManager {
    func request<T: Decodable>(_ request: HTTPRequest) -> AnyPublisher<T, AppError>
}

final class NetworkManager: INetworkManager {

    init() {}

    func request<T: Decodable>(_ request: HTTPRequest) -> AnyPublisher<T, AppError> {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        request.headers?.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw AppError.networkUnknown(URLError(.badServerResponse))
                }

                let statusCode = httpResponse.statusCode
                if !(200...299).contains(statusCode) {
                    throw AppError.serverError(statusCode)
                }

                // TODO: Handle error JSON body if needed (e.g., { "error": "Invalid token" })
                return result.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> AppError in
                if let urlError = error as? URLError {
                    if urlError.code == .notConnectedToInternet {
                        return .noInternet
                    }
                    return .networkUnknown(urlError)
                }

                if let decodingError = error as? DecodingError {
                    return .decodingError
                }

                if let appError = error as? AppError {
                    return appError
                }

                return .unknown(error)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
