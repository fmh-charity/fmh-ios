//
//  Encodable+.swift
//  fmh
//
//  Created: 07.12.2022
//

import Foundation

extension Encodable {
    
    func data(_ encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        return try encoder.encode(self)
    }
    
}
