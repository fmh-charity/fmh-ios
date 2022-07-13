//
//  DTOWishes.swift
//  fmh
//
//  Created: 12.07.22
//

import Foundation

struct DTOWishes: Codable {
    
    let createDate: Date
    let creatorID: Int
    let description: String
    let executorID: Int
    let factExecuteDate: Date
    let id: Int
    let patientID: Int
    let planExecuteDate: Date
    let status, title: String

    enum CodingKeys: String, CodingKey {
        case createDate = "createDate"
        case creatorID = "creatorId"
        case description = "description"
        case executorID = "executorId"
        case factExecuteDate = "factExecuteDate"
        case id = "id"
        case patientID = "patientId"
        case planExecuteDate = "planExecuteDate"
        case status = "status"
        case title = "title"
    }
}
