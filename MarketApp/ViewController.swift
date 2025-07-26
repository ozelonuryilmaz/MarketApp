//
//  ViewController.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 24.07.2025.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    var cancelBag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let useCase = UseCaseProvider.makeProductUseCase()
        useCase.execute(page: 1, limit: 4).sink(receiveCompletion: { result in },
                                                receiveValue: { value in
            print("Debug: 1* \(value)")
        }).store(in: &cancelBag)
        
        
        let addToCartUseCase = CartUseCaseProvider.makeAddToCartUseCase()
        addToCartUseCase.execute(CartEntity(id: "24", name: "Samsung", quantity: 2, price: "5.9")).sink(receiveCompletion: { result in }, receiveValue: { value in
            print("Debug: 2* \(value)")
        }).store(in: &cancelBag)
        
        let fetchCartItemsUseCase = CartUseCaseProvider.makeFetchCartItemsUseCase()
        fetchCartItemsUseCase.execute().sink(receiveCompletion: { result in }, receiveValue: { value in
            print("Debug: 3* \(value)")
        }).store(in: &cancelBag)
        
        
    }
    
    
}

