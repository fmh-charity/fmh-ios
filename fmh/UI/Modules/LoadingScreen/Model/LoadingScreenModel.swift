//
//  Model.swift
//  fmh
//
//  Created: 07.07.2022
//

import Foundation
import UIKit

struct LoadingScreenModel {
    
    let backgroundImage: String
    let textDescription: String
    let color: UIColor
    
}

extension LoadingScreenModel {
    
    static var data = [
        LoadingScreenModel(backgroundImage: "1", textDescription: "Хоспис – это компетентная помощь и любовь к пациентам", color: #colorLiteral(red: 0.8597510457, green: 0.9994370341, blue: 0.9968032241, alpha: 1)), 
        LoadingScreenModel(backgroundImage: "2", textDescription: "Хоспис – это наука помощи и искусство ухода", color: #colorLiteral(red: 0.9972699285, green: 0.9418493509, blue: 0.9060203433, alpha: 1)),
        LoadingScreenModel(backgroundImage: "3", textDescription: "Хоспис — это призвание и служение человечеству", color: #colorLiteral(red: 0.9793346524, green: 0.942276597, blue: 0.8411052823, alpha: 1)),
        LoadingScreenModel(backgroundImage: "4", textDescription: "Хоспис – это воплощенная гуманность", color: #colorLiteral(red: 0.8941914439, green: 1, blue: 0.8884162307, alpha: 1)),
        LoadingScreenModel(backgroundImage: "5", textDescription: "Хоспис - это комфортные условия и достойная жизнь", color: #colorLiteral(red: 0.9957950711, green: 0.9219276309, blue: 0.9336052537, alpha: 1)),
        LoadingScreenModel(backgroundImage: "6", textDescription: "Ответственно и осознанно нести добро людям", color: #colorLiteral(red: 0.9069159627, green: 0.9405061603, blue: 1, alpha: 1)),
        LoadingScreenModel(backgroundImage: "7", textDescription: "Бережное отношение к пациентам и их близким", color: #colorLiteral(red: 0.9957950711, green: 0.9219276309, blue: 0.9336052537, alpha: 1)),
        LoadingScreenModel(backgroundImage: "8", textDescription: "Чем больше мы принимаем добра, тем больше отдаем", color: #colorLiteral(red: 0.9972699285, green: 0.9418493509, blue: 0.9060203433, alpha: 1)),
        LoadingScreenModel(backgroundImage: "9", textDescription: "Творческий и осознанный подход к жизни пациента", color: #colorLiteral(red: 0.9793346524, green: 0.942276597, blue: 0.8411052823, alpha: 1)),
        LoadingScreenModel(backgroundImage: "10", textDescription: "Если пациента нельзя вылечить, это не значит, что для него ничего нельзя сделать", color: #colorLiteral(red: 0.9069159627, green: 0.9405061603, blue: 1, alpha: 1)),
        LoadingScreenModel(backgroundImage: "11", textDescription: "Ответственно и осознанно нести добро людям", color: #colorLiteral(red: 0.8597510457, green: 0.9994370341, blue: 0.9968032241, alpha: 1)),
        LoadingScreenModel(backgroundImage: "12", textDescription: "Хоспис - дом для пациентов", color: #colorLiteral(red: 0.9957950711, green: 0.9219276309, blue: 0.9336052537, alpha: 1)),
        LoadingScreenModel(backgroundImage: "13", textDescription: "Ответственно и осознанно нести добро людям", color: #colorLiteral(red: 0.9972699285, green: 0.9418493509, blue: 0.9060203433, alpha: 1)),
        LoadingScreenModel(backgroundImage: "14", textDescription: "Помощь – это создание комфорта для пациентов и их близких", color: #colorLiteral(red: 0.8941914439, green: 1, blue: 0.8884162307, alpha: 1)),
        LoadingScreenModel(backgroundImage: "15", textDescription: "Творческий и осознанный подход к жизни пациента", color: #colorLiteral(red: 0.9793346524, green: 0.942276597, blue: 0.8411052823, alpha: 1)),
        LoadingScreenModel(backgroundImage: "16", textDescription: "Добро есть везде и во всех", color: #colorLiteral(red: 0.8597510457, green: 0.9994370341, blue: 0.9968032241, alpha: 1)),
        LoadingScreenModel(backgroundImage: "17", textDescription: "Любая помощь важна и нужна", color: #colorLiteral(red: 0.9972699285, green: 0.9418493509, blue: 0.9060203433, alpha: 1))
    ]
}

