//
//  SideMenu.swift
//  fmh
//
//  Created: 11.12.2022
//

import Foundation
import UIKit

enum SideMenuItems: Int, CaseIterable {
    
    case home = 0, news, claim, wishes, chambers, documents, patients, scheduleDuty, staff, ourMission
    case instructions, aboutApp, aboutHospis
    
    case profile, logout // <- Дополнительные элементы без картинок и титлов.
    
    var title: String {
        switch self {
        case .home: return "Главная"
        case .ourMission: return "Наша миссия"
        case .news: return "Новости"
        case .claim: return "Заявки"
        case .patients: return "Пациенты"
        case .chambers: return "Палаты"
        case .wishes: return "Просьбы"
        case .documents: return "Документы"
        case .scheduleDuty: return "График дежурств"
        case .staff: return "Сотрудники"
            
        case .instructions: return "Инструкции"
        case .aboutApp: return "О приложении"
        case .aboutHospis: return "О хосписе"
            
        case .profile, .logout: return ""
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
        case .documents:
            return UIImage(systemName: "doc.on.doc.fill")
        case .scheduleDuty:
            return UIImage(systemName: "calendar")
        case .staff:
            return UIImage(systemName: "person.badge.key.fill")
            
        case .instructions:
            return UIImage(systemName: "doc")
        case .aboutApp:
            return UIImage(systemName: "info")
        case .aboutHospis:
            return UIImage(systemName: "info")
            
        case .profile, .logout: return nil
        }
        
    }
    
    var kind: String {
        return String(describing: self)
    }
    
}

