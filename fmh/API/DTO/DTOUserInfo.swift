//
//  DTOUserInfo.swift
//  fmh
//
//  Created: 08.12.2022
//

import Foundation

struct DTOUserInfo: Decodable {
    let admin: Bool
    let firstName: String
    let id: Int
    let lastName: String
    let middleName: String
}
