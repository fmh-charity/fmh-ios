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
        let imgStr: String
        let description: String
        let accentColor: UIColor
    }
    
    private var data: [Model] {
        [Model(imgStr: "", description: "Хоспис –\nэто компетентная помощь\nи любовь к пациентам", accentColor: .cyan),
         Model(imgStr: "", description: "Хоспис –\nэто наука помощи\nи искусство ухода", accentColor: .cyan),
         Model(imgStr: "", description: "Хоспис —\nэто призвание и служение\nчеловечеству", accentColor: .cyan),
         Model(imgStr: "", description: "Хоспис –\nэто воплощенная\n гуманность", accentColor: .cyan),
         Model(imgStr: "", description: "Хоспис -\nэто комфортные условия\nи достойная жизнь", accentColor: .cyan),
         Model(imgStr: "", description: "Ответственно\nи осознанно\nнести добро людям", accentColor: .cyan),
         Model(imgStr: "", description: "Бережное отношение\nк пациентам\nи их близким", accentColor: .cyan),
         Model(imgStr: "", description: "Чем больше мы\nпринимаем добра,\nтем больше отдаем", accentColor: .cyan),
         Model(imgStr: "", description: "Творческий\nи осознанный подход\nк жизни пациента", accentColor: .cyan),
         Model(imgStr: "", description: "Если пациента нельзя вылечить,\nэто не значит, что для него\nничего нельзя сделать", accentColor: .cyan),
         Model(imgStr: "", description: "Ответственно\nи осознанно\nнести добро людям", accentColor: .cyan),
         Model(imgStr: "", description: "Хоспис - дом для пациентов", accentColor: .cyan),
         Model(imgStr: "", description: "Ответственно и\nосознанно нести\nдобро людям", accentColor: .cyan),
         Model(imgStr: "", description: "Помощь – это создание\nкомфорта для пациентов и\nих близких", accentColor: .cyan),
         Model(imgStr: "", description: "Творческий\nи осознанный подход\nк жизни пациента", accentColor: .cyan),
         Model(imgStr: "", description: "Добро есть везде и во всех", accentColor: .cyan),
         Model(imgStr: "", description: "Любая помощь\nважна и нужна", accentColor: .cyan),
        ]
    }
    
}
