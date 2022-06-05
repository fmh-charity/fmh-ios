//
//  DTOCredentials.swift
//  fmh
//
//  Created: 29.04.2022
//

import Foundation

struct DTOCredentials: Codable {
    
    let login: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case login = "login"
        case password = "password"
    }
    
}

