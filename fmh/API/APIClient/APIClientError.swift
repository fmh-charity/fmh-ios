//
//  APIClientError.swift
//  fmh
//
//  Created: 16.05.2023
//

import Foundation

enum APIClientError: Error {
    case urlRequestNil
}

// MARK: - LocalizedError

extension APIClientError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .urlRequestNil: return "URL request is empty"
        }
    }
}
