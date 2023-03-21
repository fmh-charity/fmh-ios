//
//  Helper.Core.swift
//  fmh
//
//  Created: 23.11.2022
//

import Foundation

typealias Plist = Helper.Core.Plist

extension Helper.Core {
    
    struct Plist {
        
        static func getRootDictionary(forResource: String) -> [String : Any]? {
            guard let plistPath = Bundle.main.url(forResource: forResource, withExtension: "plist") else { return nil }
            guard let plistData = try? Data(contentsOf: plistPath) else { return nil }
            return try? PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as? [String:Any]
        }
        
        static func getRootArray(forResource: String) -> [Any]? {
            guard let plistPath = Bundle.main.url(forResource: forResource, withExtension: "plist") else  { return nil }
            guard let plistData = try? Data(contentsOf: plistPath) else { return nil }
            return try? PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as? [Any]
        }
        
        static func loadPropertyList(forResource: String) -> [String : Any]? {
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                .appendingPathComponent(forResource)
                .appendingPathExtension("plist")
            do {
                let data = try Data(contentsOf: path)
                guard let dict = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String:Any] else  { return nil }
                return dict
            }
            catch{
                print(error.localizedDescription)
            }
            return nil
        }
        
        static func savePropertyList(forResource: String, plist: [String : Any]) {
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                .appendingPathComponent(forResource)
                .appendingPathExtension("plist")
            do {
                let data = try PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0)
                try data.write(to: path)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Helper functions

extension Helper.Core.Plist {
    
    static func getValue(forResource: String, keyPath: String) -> Any? {
        guard let dict = Helper.Core.Plist.getRootDictionary(forResource: forResource) else { return nil }
        return dict[keyPath: keyPath]
    }
    
    static func getSettingsValue(keyPath: String) -> Any? {
        Helper.Core.Plist.getValue(forResource: "AppSettings", keyPath: keyPath)
    }
}
