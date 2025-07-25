//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 24.07.2025.
//

import Combine
import Foundation

protocol IProductRemoteDataSource {
    func fetchProducts(page: Int, limit: Int) -> AnyPublisher<[ProductDTO], NetworkError>
}

final class ProductRemoteDataSource: IProductRemoteDataSource {
    private let networkManager: INetworkManager

    init(networkManager: INetworkManager) {
        self.networkManager = networkManager
    }

    func fetchProducts(page: Int, limit: Int) -> AnyPublisher<[ProductDTO], NetworkError> {
        // TODO: Add Envirmont environment and separate Dev, Prod, and Stage configurations
        guard let url = URL(string: "https://5fc9346b2af77700165ae514.mockapi.io/products?page=\(page)&limit=\(limit)") else {
            return Fail(error: .badURL).eraseToAnyPublisher()
        }

        let request = HTTPRequest(url: url, method: .get)
        return networkManager.request(request)
    }
}
