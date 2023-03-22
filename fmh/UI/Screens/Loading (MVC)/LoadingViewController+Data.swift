//
//  LoadingViewController+Data.swift
//  fmh
//
//  Created: 27.11.2022
//

import Foundation
import UIKit

extension LoadingViewController {
    
    struct Model {
        let imgName: String
        let description: String
        let accentColor: UIColor
    }
    
    var data: [Model] {
        [Model(imgName: "loading.1",
               description: "Хоспис –\nэто компетентная помощь\nи любовь к пациентам",
               accentColor: .init(hex: "#DBFFFEFF")),
         
         Model(imgName: "loading.2",
               description: "Хоспис –\nэто наука помощи\nи искусство ухода",
               accentColor: .init(hex: "#FFF0E7")),
         
         Model(imgName: "loading.3",
               description: "Хоспис —\nэто призвание и служение\nчеловечеству",
               accentColor: .init(hex: "#FAF0D6")),
         
         Model(imgName: "loading.4",
               description: "Хоспис –\nэто воплощенная\n гуманность",
               accentColor: .init(hex: "#E4FFE3")),
         
         Model(imgName: "loading.5",
               description: "Хоспис -\nэто комфортные условия\nи достойная жизнь",
               accentColor: .init(hex: "#FFEBEE")),
         
         Model(imgName: "loading.6",
               description: "Ответственно\nи осознанно\nнести добро людям",
               accentColor: .init(hex: "#E7F0FF")),
         
         Model(imgName: "loading.7",
               description: "Бережное отношение\nк пациентам\nи их близким",
               accentColor: .init(hex: "#FFEBEE")),
         
         Model(imgName: "loading.8",
               description: "Чем больше мы\nпринимаем добра,\nтем больше отдаем",
               accentColor: .init(hex: "#FFF0E7")),
         
         Model(imgName: "loading.9",
               description: "Творческий\nи осознанный подход\nк жизни пациента",
               accentColor: .init(hex: "#FAF0D6")),
         
         Model(imgName: "loading.10",
               description: "Если пациента нельзя вылечить,\nэто не значит, что для него\nничего нельзя сделать",
               accentColor: .init(hex: "#E7F0FF")),
         
         Model(imgName: "loading.11",
               description: "Ответственно\nи осознанно\nнести добро людям",
               accentColor: .init(hex: "#DBFFFE")),
         
         Model(imgName: "loading.12",
               description: "Хоспис - дом для пациентов",
               accentColor: .init(hex: "#FFEBEE")),
         
         Model(imgName: "loading.13",
               description: "Ответственно и\nосознанно нести\nдобро людям",
               accentColor: .init(hex: "#FFF0E7")),
         
         Model(imgName: "loading.14",
               description: "Помощь – это создание\nкомфорта для пациентов и\nих близких",
               accentColor: .init(hex: "#E4FFE3")),
         
         Model(imgName: "loading.15",
               description: "Творческий\nи осознанный подход\nк жизни пациента",
               accentColor: .init(hex: "#FAF0D6")),
         
         Model(imgName: "loading.16",
               description: "Добро есть везде и во всех",
               accentColor: .init(hex: "#DBFFFE")),
         
         Model(imgName: "loading.17",
               description: "Любая помощь\nважна и нужна",
               accentColor: .init(hex: "#FFF0E7")),
        ]
    }
}
