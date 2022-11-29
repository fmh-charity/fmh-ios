//
//  Helper.Core.swift
//  fmh
//
//  Created: 23.11.2022
//

import Foundation

extension Helper.Core {
    
    /// KeyChain manager ...
    struct KeyChain {
        
        /// Save in keychain String value
        static func set(value: String, forKey key: String) {
            guard let value = value.data(using: String.Encoding.utf8) else { return }
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecValueData as String: value
            ]
            
            SecItemDelete(query as CFDictionary)
            
            let _ = SecItemAdd(query as CFDictionary, nil)
            // Обработчик ошибок нужен
        }
        
        /// Read in keychain String value
        static func get(forKey key: String) -> String? {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecReturnData as String: true,
                kSecReturnAttributes as String: true,
                kSecMatchLimit as String: kSecMatchLimitOne
            ]
            
            var item: CFTypeRef?
            let _ = SecItemCopyMatching(query as CFDictionary, &item)
            
            guard let existingItem = item as? [String : Any],
                  let valueData = existingItem[kSecValueData as String] as? Data,
                  let value = String(data: valueData, encoding: String.Encoding.utf8)
            else { return nil }
            
            return value
        }
        
        /// Delete in keychain for key
        static func del(key: String) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key
            ]
            
            let _ = SecItemDelete(query as CFDictionary)
            // Обработчик ошибок нужен
        }
        
        /// Delete in keychain all
        static  func clear() {
            let query = [
                kSecClass as String: kSecClassGenericPassword
            ]
            
            let _: OSStatus = SecItemDelete(query as CFDictionary)
            // Обработчик ошибок нужен
        }
    }
    
}
