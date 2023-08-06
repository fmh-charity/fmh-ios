//
//  Data+.swift
//  fmh
//
//  Created: 06.08.2023
//

import Foundation

extension Data {
    
    func jsonObject() throws -> Any? {
        return try JSONSerialization.jsonObject(with: self, options: [])
    }
    
    func decode<T: Decodable>(_ decoder: JSONDecoder = JSONDecoder()) throws -> T {
        return try decoder.decode(T.self, from: self)
    }
}
