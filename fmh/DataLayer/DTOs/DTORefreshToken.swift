//
//  DTORefreshToken.swift
//  fmh
//
//  Created: 29.04.2022
//

import Foundation

struct DTORefreshToken: Codable {
    
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refreshToken"
    }
    
}
