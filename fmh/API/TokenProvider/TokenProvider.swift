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
            Helper.Core.KeyChain.get(forKey: Keys.accessToken.rawValue)
        }
        set {
            guard let newValue else {
                Helper.Core.KeyChain.del(key: Keys.accessToken.rawValue)
                return
            }
            Helper.Core.KeyChain.set(value: newValue, forKey: Keys.accessToken.rawValue)
        }
    }
    
    private var refreshToken: Token? {
        get {
            Helper.Core.KeyChain.get(forKey: Keys.refreshToken.rawValue)
        }
        set {
            guard let newValue else {
                Helper.Core.KeyChain.del(key: Keys.refreshToken.rawValue)
                return
            }
            Helper.Core.KeyChain.set(value: newValue, forKey: Keys.refreshToken.rawValue)
        }
    }
    
    // MARK: - Helper
    
    static func clearTokens() {
        Helper.Core.KeyChain.del(key: Keys.accessToken.rawValue)
        Helper.Core.KeyChain.del(key: Keys.refreshToken.rawValue)
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
