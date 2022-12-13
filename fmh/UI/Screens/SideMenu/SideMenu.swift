//
//  SideMenu.swift
//  fmh
//
//  Created: 11.12.2022
//

import Foundation
import UIKit

enum SideMenu: Int, CaseIterable {

    case home = 0, ourMission, news, claim, patients, chambers, wishes
    case user, logOut
    
    var title: String {
        switch self {
        case .home: return "Главная"
        case .ourMission: return "Наша миссия"
        case .news: return "Новости"
        case .claim: return "Заявки"
        case .patients: return "Пациенты"
        case .chambers: return "Палаты"
        case .wishes: return "Просьбы"
            
        case .user: return "Пользователь"
        case .logOut: return "Выйти"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .home:
            return UIImage(systemName: "house")
        case .ourMission:
            return UIImage(systemName: "exclamationmark.circle")
        case .news:
            return UIImage(systemName: "exclamationmark.bubble")
        case .claim:
            return UIImage(systemName: "doc.plaintext")
        case .patients:
            return UIImage(systemName: "person.2")
        case .chambers:
            return UIImage(systemName: "bed.double")
        case .wishes:
            return UIImage(systemName: "checkmark")
            
        case .user:
            return UIImage(systemName: "person")
        case .logOut:
            return UIImage(systemName: "arrowshape.turn.up.right")
        }
    
    }
    
    var kind: String {
        return String(describing: self)
    }

}
