//
//  Dictionary+.swift
//  fmh
//
//  Created: 07.12.2022
//

import Foundation

extension Dictionary where Key == String, Value == Any? {
    
    func data(_ options: JSONSerialization.WritingOptions = []) throws -> Data {
        return try JSONSerialization.data(withJSONObject: self, options: options)
    }

}

extension Dictionary where Key == String, Value == String? {

    func queryItems()  -> [URLQueryItem]? {
        guard !self.isEmpty else { return nil }
        return self.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    
}
