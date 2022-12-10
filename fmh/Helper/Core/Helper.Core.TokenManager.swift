//
//  Helper.Core.TokenManager.swift
//  fmh
//
//  Created: 10.12.2022
//

import Foundation

typealias TokenManager = Helper.Core.TokenManager
 
extension Helper.Core {
    
    /// Token manager
    struct TokenManager {
        
        enum Keys: String {
            case accessToken = "accessToken"
            case refreshToken = "refreshToken"
        }
        
        static func get(_ key: Keys = .accessToken) -> String? {
            Helper.Core.KeyChain.get(forKey: key.rawValue)
        }
        
        static func update(access: String, refresh: String) {
            Helper.Core.KeyChain.set(value: access, forKey: Keys.accessToken.rawValue)
            Helper.Core.KeyChain.set(value: refresh, forKey: Keys.refreshToken.rawValue)
            UserDefaults.standard.set(Date(), forKey: "dateUpdatedTokens") // <-  PLIST!
            // Write to PLIST
        }
        
        static func clear() {
            Helper.Core.KeyChain.del(key: Keys.accessToken.rawValue)
            Helper.Core.KeyChain.del(key: Keys.refreshToken.rawValue)
        }
        
        // Additional ...
        static func set(key: Keys = .accessToken, value: String) {
            Helper.Core.KeyChain.set(value: value, forKey: key.rawValue)
        }
        
        static func del(_ key: Keys = .accessToken) {
            Helper.Core.KeyChain.del(key: key.rawValue)
        }
        
    }
    
}
