//
//  HTTPMethod.swift
//  fmh
//
//  Created: 29.04.2022
//

import Foundation

struct HTTPMethod: Hashable {
    
    static let get = HTTPMethod(rawValue: "GET")
    static let post = HTTPMethod(rawValue: "POST")
    static let put = HTTPMethod(rawValue: "PUT")
    static let delete = HTTPMethod(rawValue: "DELETE")

    let rawValue: String
    
}


