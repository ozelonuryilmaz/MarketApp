//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 24.07.2025.
//

import Foundation

// TODO: Unify NetworkError and CoreData errors into a single error source.
// Errors should be propagated through the UseCase layer.
// In the future, UseCase will need access to data.
// This data may come from either Local or Remote sources.
enum AppError: LocalizedError, Equatable {
    // Network
    case badURL
    case noInternet
    case serverError(Int)
    case decodingError
    case networkUnknown(Error)

    // Local (CoreData vs.)
    case databaseError(String)
    case saveFailed
    case fetchFailed
    case localUnknown(Error)

    // Common
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .badURL: return "Invalid URL"
        case .noInternet: return "No internet connection"
        case .serverError(let code): return "Server error with code \(code)"
        case .decodingError: return "Decoding response failed"
        case .networkUnknown(let err): return err.localizedDescription

        case .databaseError(let msg): return "Database error: \(msg)"
        case .saveFailed: return "Failed to save data"
        case .fetchFailed: return "Failed to fetch data"
        case .localUnknown(let err): return err.localizedDescription

        case .unknown(let err): return err.localizedDescription
        }
    }

    static func == (lhs: AppError, rhs: AppError) -> Bool {
        switch (lhs, rhs) {
        case (.badURL, .badURL),
             (.noInternet, .noInternet),
             (.decodingError, .decodingError),
             (.saveFailed, .saveFailed),
             (.fetchFailed, .fetchFailed):
            return true
        case let (.serverError(a), .serverError(b)):
            return a == b
        case let (.databaseError(a), .databaseError(b)):
            return a == b
        case let (.networkUnknown(a), .networkUnknown(b)),
             let (.localUnknown(a), .localUnknown(b)),
             let (.unknown(a), .unknown(b)):
            return (a as NSError).domain == (b as NSError).domain &&
                   (a as NSError).code == (b as NSError).code
        default:
            return false
        }
    }
}
