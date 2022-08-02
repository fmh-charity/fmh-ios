//
//  DTOUserInfo.swift
//  fmh
//
//  Created: 29.04.2022
//

import Foundation

struct DTOUserInfo: Codable {
    
    let admin: Bool
    let firstName: String
    let id: Int
    let lastName: String
    let middleName: String
    
    enum CodingKeys: String, CodingKey {
        case admin = "admin"
        case firstName = "firstName"
        case id = "id"
        case lastName = "lastName"
        case middleName = "middleName"
    }
    
}
