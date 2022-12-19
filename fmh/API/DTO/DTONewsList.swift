//
//  APIDTONewsList.swift
//  fmh
//
//  Created: 24.09.2022
//

import Foundation

struct DTONewsList: Codable {
    let elements: [DTONews]
    let pages: Int
}
