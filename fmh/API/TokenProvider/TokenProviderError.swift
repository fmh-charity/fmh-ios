//
//  TokenProviderError.swift
//  fmh
//
//  Created: 15.05.2023
//

import Foundation

enum TokenProviderError: Error {
    case accessTokenNil, refreshTokenNil
}

// MARK: - LocalizedError

extension TokenProviderError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .accessTokenNil:    return "Access token is empty"
        case .refreshTokenNil:   return "Refresh token is empty"
        }
    }
}
