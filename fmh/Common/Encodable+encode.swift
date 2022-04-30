//
//  Encodable+encode.swift
//  fmh
//
//  Created: 29.04.2022
//

import Foundation

extension Encodable {
    func encode() throws -> Data? {
        try? JSONEncoder().encode(self)
    }
}
