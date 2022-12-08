//
//  DTOJWT.swift
//  fmh
//
//  Created: 08.12.2022
//

import Foundation

struct DTOJWT: Codable {
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
    }
    
}
