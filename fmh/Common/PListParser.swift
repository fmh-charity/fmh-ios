//
//  PListParser.swift
//  fmh
//
//  Created: 30.04.2022
//

import Foundation


struct PListParser {
    
    typealias DictionaryType = [String: Any]
    typealias ArrayType = [Any]
    
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

