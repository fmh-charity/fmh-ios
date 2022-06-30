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
    let chamber: String
    let numberOfPost: String
    let post: String
    let numberOfBlock: String
    let block: String
    let numberOfFreePlaces: String
    let freePlaces: String
    let comment: String
    let nameOfComment: String
    
    static let chambers: [ChamberModel] = [
        ChamberModel(numberOfChamber: DecriptionChamber.numberOfChamber.title,
                     chamber: "1",
                     numberOfPost: DecriptionChamber.post.title,
                     post: "1",
                     numberOfBlock: DecriptionChamber.block.title,
                     block: "1",
                     numberOfFreePlaces: DecriptionChamber.freePlaces.title,
                     freePlaces: "2",
                     comment: DecriptionChamber.comment.title,
                     nameOfComment: ""),
        ChamberModel(numberOfChamber: DecriptionChamber.numberOfChamber.title,
                     chamber: "2",
                     numberOfPost: DecriptionChamber.post.title,
                     post: "1",
                     numberOfBlock: DecriptionChamber.block.title,
                     block: "1",
                     numberOfFreePlaces: DecriptionChamber.freePlaces.title,
                     freePlaces: "0",
                     comment: DecriptionChamber.comment.title,
                     nameOfComment: ""),
        ChamberModel(numberOfChamber: DecriptionChamber.numberOfChamber.title,
                     chamber: "3",
                     numberOfPost: DecriptionChamber.post.title,
                     post: "1",
                     numberOfBlock: DecriptionChamber.block.title,
                     block: "1",
                     numberOfFreePlaces: DecriptionChamber.freePlaces.title,
                     freePlaces: "1",
                     comment: DecriptionChamber.comment.title,
                     nameOfComment: "Палата адаптирована для лежачих больных"),
        ChamberModel(numberOfChamber: DecriptionChamber.numberOfChamber.title,
                     chamber: "4",
                     numberOfPost: DecriptionChamber.post.title,
                     post: "1",
                     numberOfBlock: DecriptionChamber.block.title,
                     block: "1",
                     numberOfFreePlaces: DecriptionChamber.freePlaces.title,
                     freePlaces: "0",
                     comment: DecriptionChamber.comment.title,
                     nameOfComment: ""),
        ChamberModel(numberOfChamber: DecriptionChamber.numberOfChamber.title,
                     chamber: "5",
                     numberOfPost: DecriptionChamber.post.title,
                     post: "2",
                     numberOfBlock: DecriptionChamber.block.title,
                     block: "2",
                     numberOfFreePlaces: DecriptionChamber.freePlaces.title,
                     freePlaces: "1",
                     comment: DecriptionChamber.comment.title,
                     nameOfComment: "В палате есть душ"),
        ChamberModel(numberOfChamber: DecriptionChamber.numberOfChamber.title,
                     chamber: "6",
                     numberOfPost: DecriptionChamber.post.title,
                     post: "2",
                     numberOfBlock: DecriptionChamber.block.title,
                     block: "2",
                     numberOfFreePlaces: DecriptionChamber.freePlaces.title,
                     freePlaces: "1",
                     comment: DecriptionChamber.comment.title,
                     nameOfComment: ""),
        ChamberModel(numberOfChamber: DecriptionChamber.numberOfChamber.title,
                     chamber: "7",
                     numberOfPost: DecriptionChamber.post.title,
                     post: "2",
                     numberOfBlock: DecriptionChamber.block.title,
                     block: "2",
                     numberOfFreePlaces: DecriptionChamber.freePlaces.title,
                     freePlaces: "0",
                     comment: DecriptionChamber.comment.title,
                     nameOfComment: ""),
        ChamberModel(numberOfChamber: DecriptionChamber.numberOfChamber.title,
                     chamber: "8",
                     numberOfPost: DecriptionChamber.post.title,
                     post: "2",
                     numberOfBlock: DecriptionChamber.block.title,
                     block: "2",
                     numberOfFreePlaces: DecriptionChamber.freePlaces.title,
                     freePlaces: "0",
                     comment: DecriptionChamber.comment.title,
                     nameOfComment: ""),
        ChamberModel(numberOfChamber: DecriptionChamber.numberOfChamber.title,
                     chamber: "9",
                     numberOfPost: DecriptionChamber.post.title,
                     post: "2",
                     numberOfBlock: DecriptionChamber.block.title,
                     block: "2",
                     numberOfFreePlaces: DecriptionChamber.freePlaces.title,
                     freePlaces: "0",
                     comment: DecriptionChamber.comment.title,
                     nameOfComment: ""),
        ChamberModel(numberOfChamber: DecriptionChamber.numberOfChamber.title,
                     chamber: "10",
                     numberOfPost: DecriptionChamber.post.title,
                     post: "2",
                     numberOfBlock: DecriptionChamber.block.title,
                     block: "2",
                     numberOfFreePlaces: DecriptionChamber.freePlaces.title,
                     freePlaces: "1",
                     comment: DecriptionChamber.comment.title,
                     nameOfComment: "В палате есть душ")
    ]
    
    //    static let chambers: [ChamberModel] = [
    //        ChamberModel(numberOfChamber: "1", post: "1", block: "1", freePlaces: "2", comment: ""),
    //        ChamberModel(numberOfChamber: "2", post: "1", block: "1", freePlaces: "0", comment: ""),
    //        ChamberModel(numberOfChamber: "3", post: "1", block: "1", freePlaces: "1", comment: "Палата адаптирована для лежачих больных"),
    //        ChamberModel(numberOfChamber: "4", post: "1", block: "1", freePlaces: "0", comment: ""),
    //        ChamberModel(numberOfChamber: "5", post: "2", block: "2", freePlaces: "1", comment: "В палате есть душ"),
    //        ChamberModel(numberOfChamber: "6", post: "2", block: "2", freePlaces: "1", comment: ""),
    //        ChamberModel(numberOfChamber: "7", post: "2", block: "2", freePlaces: "0", comment: ""),
    //        ChamberModel(numberOfChamber: "8", post: "2", block: "2", freePlaces: "2", comment: "Палата адаптирована для лежачих больных"),
    //        ChamberModel(numberOfChamber: "9", post: "2", block: "2", freePlaces: "0", comment: ""),
    //        ChamberModel(numberOfChamber: "10", post: "2", block: "2", freePlaces: "1", comment: "В палате есть душ")
    //    ]
    
}
