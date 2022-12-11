//
//  Data+.swift
//  fmh
//
//  Created: 07.12.2022
//

import Foundation

extension Data {
    
    func jsonObject() -> Any? {
        return (try? JSONSerialization.jsonObject(with: self, options: []))
    }
    
    func decode<T: Decodable>(_ decoder: JSONDecoder = JSONDecoder()) throws -> T {
        return try decoder.decode(T.self, from: self)
    }
    
}