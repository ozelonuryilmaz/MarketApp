//
//  File.swift
//  MarketDomain
//
//  Created by Onur Yılmaz on 25.07.2025.
//

import Foundation

enum CartUseCaseProvider {
    
    static func makeAddToCartUseCase() -> AddToCartUseCase {
        return AddToCartUseCase(repository: self.makeCartRepository())
    }
    
    static func makeFetchCartItemsUseCase() -> FetchCartItemsUseCase {
        return FetchCartItemsUseCase(repository: self.makeCartRepository())
    }
    
    private static func makeCartRepository() -> ICartRepository {
        let coreDataHelper = CoreDataHelper()
        let managedContext = coreDataHelper.getManagedContextWithMergePolicy()
        let localDataSource: ICartLocalDataSource = CartLocalDataSource(managedContext: managedContext)
        let cartRepository: ICartRepository = CartRepository(localDataSource: localDataSource)
        return cartRepository
    }
}
