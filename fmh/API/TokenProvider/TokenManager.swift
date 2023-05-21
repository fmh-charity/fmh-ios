//
//  TokenProvider.swift
//  fmh
//
//  Created: 15.05.2023
//

import Foundation

actor TokenProvider {
    
    typealias Token = String
    
    private var currentToken: Token?
    private var refreshTask: Task<Token, Error>?
    
    func validToken() async throws -> Token {
        
        if let handle = refreshTask {
            return try await handle.value
        }
        
        guard let token = currentToken else {
            throw TokenManagerError.missingToken
        }
        
        if token.isValid {
            return token
        }
        
        return try await refreshToken()
    }
    
    func refreshToken() async throws -> Token {
        
    }
}
