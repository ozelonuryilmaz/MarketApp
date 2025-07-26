//
//  BaseRepository.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import Foundation
import Combine

protocol IBaseRepository: AnyObject {
    
}

class BaseRepository: IBaseRepository {
    
    var cancelBag = Set<AnyCancellable>()
    
    deinit {
        print("killed: \(type(of: self))")
    }
    
}
