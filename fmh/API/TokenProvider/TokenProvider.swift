//
//  TokenProvider.swift
//  fmh
//
//  Created: 15.05.2023
//

import Foundation

actor TokenProvider {
    
    typealias Token = String
    
    enum Keys: String {
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
    }
    
    private var accessToken: Token? {
        get {
            KeyChainManager.get(forKey: Keys.accessToken.rawValue)
        }
        set {
            guard let newValue else {
                KeyChainManager.del(key: Keys.accessToken.rawValue)
                return
            }
            KeyChainManager.set(value: newValue, forKey: Keys.accessToken.rawValue)
        }
    }
    
    private var refreshToken: Token? {
        get {
            KeyChainManager.get(forKey: Keys.refreshToken.rawValue)
        }
        set {
            guard let newValue else {
                KeyChainManager.del(key: Keys.refreshToken.rawValue)
                return
            }
            KeyChainManager.set(value: newValue, forKey: Keys.refreshToken.rawValue)
        }
    }
}

// MARK: - TokenProviderProtocol

extension TokenProvider: TokenProviderProtocol {
    
    func getAccessToken() async throws -> String {
        
        guard let accessToken else {
            throw TokenProviderError.accessTokenNil
        }
        
        return accessToken
    }
    
    func getRefreshToken() async throws -> String {
        
        guard let refreshToken else {
            throw TokenProviderError.accessTokenNil
        }
        
        return refreshToken
    }
    
    func setTokens(accessToken: String?, refreshToken: String?) async {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}

// MARK: - Helper

extension TokenProvider {
    
    static func clearTokens() {
        KeyChainManager.del(key: Keys.accessToken.rawValue)
        KeyChainManager.del(key: Keys.refreshToken.rawValue)
    }
}
