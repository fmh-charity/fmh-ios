//
//  DTOWishes.swift
//  fmh
//
//  Created: 12.07.22
//

import Foundation

struct DTOWishes: Codable {
    
    let createDate: Date
    let creatorId: Int
    let description: String
    let executorId: Int
    let factExecuteDate: Date
    let id: Int
    let patientId: Int
    let planExecuteDate: Date
    let status: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case createDate = "createDate"
        case creatorId = "creatorId"
        case description = "description"
        case executorId = "executorId"
        case factExecuteDate = "factExecuteDate"
        case id = "id"
        case patientId = "patientId"
        case planExecuteDate = "planExecuteDate"
        case status = "status"
        case title = "title"
    }
}
