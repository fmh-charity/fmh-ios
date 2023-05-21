//
//  APIServiceError.swift
//  fmh
//
//  Created: 20.05.2023
//

import Foundation

enum APIServiceError: Error {
    case responseError(_ code: Int, _ description: String)
}

// MARK: - LocalizedError

extension APIServiceError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case let .responseError(code, description): return "Response code: \(code). \(description)"
        }
    }
}
