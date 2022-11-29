//
//  Helper.Core.swift
//  fmh
//
//  Created: 23.11.2022
//

import Foundation

extension Helper.Core {
    
    /// Plist file manager
    struct Plist {
        
        typealias DictionaryType = [String: Any]
        typealias ArrayType = [Any]
        
        /// Get Dictinary value "Any"
        static func getValueDictionary(forResource: String, forKey key: String) -> Any? {
            if let infoPlistPath = Bundle.main.url(forResource: forResource, withExtension: "plist") {
                do {
                    let infoPlistData = try Data(contentsOf: infoPlistPath)
                    if let dict = try PropertyListSerialization.propertyList(from: infoPlistData, options: [], format: nil) as? DictionaryType {
                        return dict[key]
                    }
                } catch {
                    return nil
                }
            }
            return nil
        }
        
        /// Get Array value "Any"
        static func getValueArray(forResource: String, forId id: Int) -> Any? {
            if let infoPlistPath = Bundle.main.url(forResource: forResource, withExtension: "plist") {
                do {
                    let infoPlistData = try Data(contentsOf: infoPlistPath)
                    if let array = try PropertyListSerialization.propertyList(from: infoPlistData, options: [], format: nil) as? ArrayType {
                        return array[id]
                    }
                } catch {
                    return nil
                }
            }
            return nil
        }
        
    }
    
}
