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
        let _ = addToCartUseCase.execute(CartEntity(id: "1", name: "Apple", quantity: 1, price: "2.5"))
        
        let fetchCartItemsUseCase = CartUseCaseProvider.makeFetchCartItemsUseCase()
        print("Debug: 2* \(fetchCartItemsUseCase.execute())")
        
        
    }


}

