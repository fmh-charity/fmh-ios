//
//  ChamberModel.swift
//  fmh
//
//  Created: 14.06.2022
//

import Foundation

struct ChamberModel: Identifiable {
    
    let id = UUID()
    let numberOfChamber: String
    let post: String
    let block: String
    let freePlaces: String
    let comment: String
    
    static let chambers: [ChamberModel] = [
        ChamberModel(numberOfChamber: "1", post: "1", block: "1", freePlaces: "2", comment: ""),
        ChamberModel(numberOfChamber: "2", post: "1", block: "1", freePlaces: "0", comment: ""),
        ChamberModel(numberOfChamber: "3", post: "1", block: "1", freePlaces: "1", comment: "Палата адаптирована для лежачих больных"),
        ChamberModel(numberOfChamber: "4", post: "1", block: "1", freePlaces: "0", comment: ""),
        ChamberModel(numberOfChamber: "5", post: "2", block: "2", freePlaces: "1", comment: "В палате есть душ"),
        ChamberModel(numberOfChamber: "6", post: "2", block: "2", freePlaces: "1", comment: ""),
        ChamberModel(numberOfChamber: "7", post: "2", block: "2", freePlaces: "0", comment: ""),
        ChamberModel(numberOfChamber: "8", post: "2", block: "2", freePlaces: "2", comment: "Палата адаптирована для лежачих больных"),
        ChamberModel(numberOfChamber: "9", post: "2", block: "2", freePlaces: "0", comment: ""),
        ChamberModel(numberOfChamber: "10", post: "2", block: "2", freePlaces: "1", comment: "В палате есть душ")
    ]
    
}
