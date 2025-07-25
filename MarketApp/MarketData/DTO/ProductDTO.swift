//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 24.07.2025.
//

struct ProductDTO: Decodable {
    let image: String
    let name: String
    
    init(image: String, name: String) {
        self.name = name
        self.image = image
    }
}
