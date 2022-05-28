//
//  GeneralMenu.swift
//  fmh
//
//  Created: 27.05.2022
//

import UIKit

enum GeneralMenu: String, CaseIterable {
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
            return UIImage(systemName: "bed.double") // UIImage(named: "chamber")
        }
    }
}

//MARK: - Additional menu
extension GeneralMenu {
    
    enum AdditionalMenu: String, CaseIterable {
        case user = "Пользователь"
        case logOut = "Выйти"
        
        var image: UIImage? {
            switch self {
            case .user:
                return UIImage(systemName: "person")
            case .logOut:
                return UIImage(systemName: "arrowshape.turn.up.right")
            }
        }
    }
    
}
