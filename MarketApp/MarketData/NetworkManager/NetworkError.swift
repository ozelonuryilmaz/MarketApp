//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 24.07.2025.
//

import Foundation

enum NetworkError: LocalizedError, Equatable {
    case badURL
    case noInternet
    case serverError(Int)
    case decodingError
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .badURL: return "Invalid URL"
        case .noInternet: return "No internet connection"
        case .serverError(let code): return "Server returned error code \(code)"
        case .decodingError: return "Failed to decode response"
        case .unknown(let error): return error.localizedDescription
        }
    }

    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.badURL, .badURL),
             (.noInternet, .noInternet),
             (.decodingError, .decodingError):
            return true
        case let (.serverError(a), .serverError(b)):
            return a == b
        case let (.unknown(a), .unknown(b)):
            return (a as NSError).domain == (b as NSError).domain &&
                   (a as NSError).code == (b as NSError).code
        default:
            return false
        }
    }
}
