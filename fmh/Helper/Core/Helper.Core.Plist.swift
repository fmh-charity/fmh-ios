//
//  Helper.Core.swift
//  fmh
//
//  Created: 23.11.2022
//

import Foundation

typealias Plist = Helper.Core.Plist

extension Helper.Core {
    
    /// Plist file manager
    struct Plist {
        
        /// Get root dictioanry
        static func getRootDictionary(forResource: String) -> [String : Any]? {
            guard let plistPath = Bundle.main.url(forResource: forResource, withExtension: "plist") else {
                return nil
            }
            guard let plistData = try? Data(contentsOf: plistPath) else { return nil }
            
            return try? PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as? [String:Any]
        }
        
        /// Get root array
        static func getRootArray(forResource: String) -> [Any]? {
            guard let plistPath = Bundle.main.url(forResource: forResource, withExtension: "plist") else {
                return nil
            }
            guard let plistData = try? Data(contentsOf: plistPath) else { return nil }
            
            return try? PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as? [Any]
        }
        
        /// Load plist in documentDirectory
        static func loadPropertyList(forResource: String) -> [String : Any]? {
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                .appendingPathComponent(forResource)
                .appendingPathExtension("plist")
            
            do {
                let data = try Data(contentsOf: path)
                guard let dict = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String:Any] else{
                    return nil
                }
                return dict
            }
            catch{
                print(error.localizedDescription)
            }
            return nil
        }
        
        /// Save plist in documentDirectory
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

extension Helper.Core.Plist {
    
    /// Get value Any by keyPath
    static func getValue(forResource: String, keyPath: String) -> Any? {
        guard let dict = Helper.Core.Plist.getRootDictionary(forResource: forResource) else { return nil }
        return dict[keyPath: keyPath]
    }
    
    /// Get value in AppSettings.plist by keyPath
    static func getSettingsValue(keyPath: String) -> Any? {
        Helper.Core.Plist.getValue(forResource: "AppSettings", keyPath: keyPath)
    }
    
}


// https://gist.github.com/dfrib/d7419038f7e680d3f268750d63f0dfae
extension Dictionary {
    
    subscript(keyPath keyPath: String) -> Any? {
        get {
            guard let keyPath = Dictionary.keyPathKeys(forKeyPath: keyPath)
            else { return nil }
            return getValue(forKeyPath: keyPath)
        }
        set {
            guard let keyPath = Dictionary.keyPathKeys(forKeyPath: keyPath),
                  let newValue = newValue else { return }
            self.setValue(newValue, forKeyPath: keyPath)
        }
    }
    
    static private func keyPathKeys(forKeyPath: String) -> [Key]? {
        let keys = forKeyPath.components(separatedBy: ".")
            .reversed().compactMap({ $0 as? Key })
        return keys.isEmpty ? nil : keys
    }
    
    // recursively (attempt to) access queried subdictionaries
    // (keyPath will never be empty here; the explicit unwrapping is safe)
    private func getValue(forKeyPath keyPath: [Key]) -> Any? {
        guard let value = self[keyPath.last!] else { return nil }
        return keyPath.count == 1 ? value : (value as? [Key: Any])
            .flatMap { $0.getValue(forKeyPath: Array(keyPath.dropLast())) }
    }
    
    // recursively (attempt to) access the queried subdictionaries to
    // finally replace the "inner value", given that the key path is valid
    private mutating func setValue(_ value: Any, forKeyPath keyPath: [Key]) {
        guard self[keyPath.last!] != nil else { return }
        if keyPath.count == 1 {
            (value as? Value).map { self[keyPath.last!] = $0 }
        }
        else if var subDict = self[keyPath.last!] as? [Key: Value] {
            subDict.setValue(value, forKeyPath: Array(keyPath.dropLast()))
            (subDict as? Value).map { self[keyPath.last!] = $0 }
        }
    }
    
}
