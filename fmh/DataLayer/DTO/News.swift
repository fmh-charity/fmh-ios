//
//  News.swift
//  fmh
//
//  Created: 03.06.2022
//

import Foundation

struct News: Codable {
    
    let createDate: Date
    let creatorId: Int
    let creatorName: String
    let description: String
    let id: Int
    let newsCategoryId: Int
    let publishDate: Date
    let publishEnabled: Bool
    let title: String
    
}
