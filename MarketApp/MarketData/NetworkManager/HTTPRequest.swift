//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 24.07.2025.
//

import Foundation

struct HTTPRequest {
    let url: URL
    let method: HTTPMethod
    let headers: [String: String]?
    let body: Data?
    
    init(url: URL, method: HTTPMethod = .get, headers: [String: String]? = nil, body: Data? = nil) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
    }
    
    init<E: Encodable>(url: URL, method: HTTPMethod = .post, headers: [String: String]? = ["Content-Type": "application/json"], bodyObject: E) {
        let encoder = JSONEncoder()
        let body = try? encoder.encode(bodyObject)
        self.init(url: url, method: method, headers: headers, body: body)
    }
}
