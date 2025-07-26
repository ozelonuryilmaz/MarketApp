//
//  File.swift
//  MarketDomain
//
//  Created by Onur Yılmaz on 25.07.2025.
//

import MarketData

enum UseCaseProvider {

    static func makeProductUseCase() -> ProductUseCase {
        let networkManager: INetworkManager = NetworkManager()
        let remoteDataSource: IProductRemoteDataSource = ProductRemoteDataSource(networkManager: networkManager)
        let productRepository: IProductRepository = ProductRepository(remoteDataSource: remoteDataSource)
        return ProductUseCase(productRepository: productRepository)
    }
}
