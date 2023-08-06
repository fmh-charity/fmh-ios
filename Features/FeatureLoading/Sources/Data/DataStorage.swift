//
//  DataStorage.swift
//  
//
//  Created by Константин Туголуков on 05.08.2023.
//

import Foundation

final class DataStorage {
    
    init() { }
}

// MARK: - DataRepositoryProtocol

extension DataStorage: DataStorageProtocol {
    
    func fetchData() -> [DataModel] {
        data
    }
}

// MARK: - Data generate

extension DataStorage {
    
    var data: [DataModel] {[
        .init(colorHex: "#DBFFFEFF", imageName: "loading.1", description: "Хоспис –\nэто компетентная помощь\nи любовь к пациентам"),
        
            .init(
                colorHex: "#DBFFFEFF",
                imageName: "loading.1",
                description: "Хоспис –\nэто компетентная помощь\nи любовь к пациентам"
            ),
        
            .init(
                colorHex: "#FFF0E7",
                imageName: "loading.2",
                description: "Хоспис –\nэто наука помощи\nи искусство ухода"
            ),
        
            .init(
                colorHex: "#FAF0D6",
                imageName: "loading.3",
                description: "Хоспис —\nэто призвание и служение\nчеловечеству"
            ),
        
            .init(
                colorHex: "#E4FFE3",
                imageName: "loading.4",
                description: "Хоспис –\nэто воплощенная\n гуманность"
            ),
        
            .init(
                colorHex: "#FFEBEE",
                imageName: "loading.5",
                description: "Хоспис -\nэто комфортные условия\nи достойная жизнь"
            ),
        
            .init(
                colorHex: "#E7F0FF",
                imageName: "loading.6",
                description: "Ответственно\nи осознанно\nнести добро людям"
            ),
        
            .init(
                colorHex: "#FFEBEE",
                imageName: "loading.7",
                description: "Бережное отношение\nк пациентам\nи их близким"
            ),
        
            .init(
                colorHex: "#FFF0E7",
                imageName: "loading.8",
                description: "Чем больше мы\nпринимаем добра,\nтем больше отдаем"
            ),
        
            .init(
                colorHex: "#FAF0D6",
                imageName: "loading.9",
                description: "Творческий\nи осознанный подход\nк жизни пациента"
            ),
        
            .init(
                colorHex: "#E7F0FF",
                imageName: "loading.10",
                description: "Если пациента нельзя вылечить,\nэто не значит, что для него\nничего нельзя сделать"
            ),
        
            .init(
                colorHex: "#DBFFFE",
                imageName: "loading.11",
                description: "Ответственно\nи осознанно\nнести добро людям"
            ),
        
            .init(
                colorHex: "#FFEBEE",
                imageName: "loading.12",
                description: "Хоспис - дом для пациентов"
            ),
        
            .init(
                colorHex: "#FFF0E7",
                imageName: "loading.13",
                description: "Ответственно и\nосознанно нести\nдобро людям"
            ),
        
            .init(
                colorHex: "#E4FFE3",
                imageName: "loading.14",
                description: "Помощь – это создание\nкомфорта для пациентов и\nих близких"
            ),
        
            .init(
                colorHex: "#FAF0D6",
                imageName: "loading.15",
                description: "Творческий\nи осознанный подход\nк жизни пациента"
            ),
        
            .init(
                colorHex: "#DBFFFE",
                imageName: "loading.16",
                description: "Добро есть везде и во всех"
            ),
        
            .init(
                colorHex: "#FFF0E7",
                imageName: "loading.17",
                description: "Любая помощь\nважна и нужна"
            ),
    ]}
}
