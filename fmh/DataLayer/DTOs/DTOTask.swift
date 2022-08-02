//
//  DTOTasks.swift
//  fmh
//
//  Created: 09.06.2022
//

import Foundation

struct DTOTask: Codable {
    let createDate: Int
    let creatorId: Int
    let creatorName: String
    let description: String
    let executorId: Int
    let executorName: String
    let factExecuteDate: Int
    let id: Int
    let planExecuteDate: Int
    let status: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case createDate = "createDate"
        case creatorId = "creatorId"
        case creatorName = "creatorName"
        case description = "description"
        case executorId = "executorId"
        case executorName = "executorName"
        case factExecuteDate = "factExecuteDate"
        case id = "id"
        case planExecuteDate = "planExecuteDate"
        case status = "status"
        case title = "title"
    }
}

var taskModelCells_ = [
    DTOTask(createDate: 10, creatorId: 1, creatorName: "Vitaliy", description: "Pidor", executorId: 228, executorName: "Maxim", factExecuteDate: 10, id: 1, planExecuteDate: 23, status: "Work", title: "Heeeey"),
    DTOTask(createDate: 10, creatorId: 1, creatorName: "Vitaliy", description: "Pidor", executorId: 228, executorName: "Maxim", factExecuteDate: 10, id: 1, planExecuteDate: 23, status: "Work", title: "Heeeey"),
    DTOTask(createDate: 10, creatorId: 1, creatorName: "Vitaliy", description: "Pidor", executorId: 228, executorName: "Maxim", factExecuteDate: 10, id: 1, planExecuteDate: 23, status: "Work", title: "Heeeey"),
    DTOTask(createDate: 10, creatorId: 1, creatorName: "Vitaliy", description: "Pidor", executorId: 228, executorName: "Maxim", factExecuteDate: 10, id: 1, planExecuteDate: 23, status: "Work", title: "Heeeey")
]
