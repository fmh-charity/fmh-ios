//
//  APIDTONews.swift
//  fmh
//
//  Created: 03.06.2022
//

import Foundation

struct DTONews: Codable {
    
    let createDate: Int64?
    let creatorId: Int?
    let creatorName: String?
    let description: String?
    let id: Int?
    let newsCategoryId: Int?
    let publishDate: Int64?
    let publishEnabled: Bool?
    let title: String?
    
    enum CodingKeys: String, CodingKey {
        case createDate = "createDate"
        case creatorId = "creatorId"
        case creatorName = "creatorName"
        case description = "description"
        case id = "id"
        case newsCategoryId = "newsCategoryId"
        case publishDate = "publishDate"
        case publishEnabled = "publishEnabled"
        case title = "title"
    }
    
}
