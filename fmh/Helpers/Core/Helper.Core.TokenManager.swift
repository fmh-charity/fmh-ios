//
//  Helper.Core.TokenManager.swift
//  fmh
//
//  Created: 10.12.2022
//

import Foundation

typealias TokenManager = Helper.Core.TokenManager
 
extension Helper.Core {
    
    struct TokenManager {
        
        enum Keys: String {
            case accessToken = "accessToken"
            case refreshToken = "refreshToken"
        }
        
        static func isEmpty() -> Bool {
            (Helper.Core.KeyChain.get(forKey: Keys.accessToken.rawValue) == nil) &&
            (Helper.Core.KeyChain.get(forKey: Keys.refreshToken.rawValue) == nil)
        }
        
        static func get(_ key: Keys = .accessToken) -> String? {
            Helper.Core.KeyChain.get(forKey: key.rawValue)
        }
        
        static func update(access: String, refresh: String) {
            Helper.Core.KeyChain.set(value: access, forKey: Keys.accessToken.rawValue)
            Helper.Core.KeyChain.set(value: refresh, forKey: Keys.refreshToken.rawValue)
        }
        
        static func clear() {
            Helper.Core.KeyChain.del(key: Keys.accessToken.rawValue)
            Helper.Core.KeyChain.del(key: Keys.refreshToken.rawValue)
        }
        
        // MARK: - Additional ...
        
        static func set(key: Keys = .accessToken, value: String) {
            Helper.Core.KeyChain.set(value: value, forKey: key.rawValue)
        }
        
        static func del(_ key: Keys = .accessToken) {
            Helper.Core.KeyChain.del(key: key.rawValue)
        }
    }
}
