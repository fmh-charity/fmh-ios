//
//  DTOTokenData.swift
//  fmh
//
//  Created: 29.04.2022
//

import Foundation

struct DTOTokenData: Codable {
    
    let accessToken: String
    let refreshToken: String
 
    enum CodingKeys: String, CodingKey {
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
    }
    
}
