//
//  GeneralMenuViewController + MenuOptions.swift
//  fmh
//
//  Created: 21.05.2022
//

import Foundation
import UIKit

extension GeneralMenuViewController {
    
    enum MenuOptions: String, CaseIterable {
        case home = "Главная"
        case urMission = "Наша миссия"
        case news = "Новости"
        case claim = "Заявки"
        case patients = "Пациенты"
        case chambers = "Палаты"
        
        var image: UIImage? {
            switch self {
            case .home:
                return UIImage(systemName: "house")
            case .urMission:
                return UIImage(systemName: "exclamationmark.circle")
            case .news:
                return UIImage(systemName: "exclamationmark.bubble")
            case .claim:
                return UIImage(systemName: "doc.plaintext")
            case .patients:
                return UIImage(systemName: "person.2")
            case .chambers:
                return UIImage(systemName: "bed.double")
            }
        }
    }
    
    /// Additional menu
    enum AdditionalMenuOptions: String, CaseIterable {
        case settings = "Настройки"
        case logOut = "Выйти"
        
        var image: UIImage? {
            switch self {
            case .settings:
                return UIImage(systemName: "gear")
            case .logOut:
                return UIImage(systemName: "arrowshape.turn.up.right")
            }
        }
    }
    
}
