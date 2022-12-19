//
//  DTONews + extension.swift
//  fmh
//
//  Created: 05.06.2022
//

import UIKit

extension DTONews {
    
    var categoryImg: UIImage? {
        switch self.newsCategoryId {
        case 1:
            return UIImage(named: "announcement")
        case 2:
            return UIImage(named: "birthday")
        case 3:
            return UIImage(named: "salary")
        case 4:
            return UIImage(named: "tradeUnion")
        case 5:
            return UIImage(named: "holiday")
        case 6:
            return UIImage(named: "massage")
        case 7:
            return UIImage(named: "gratitude")
        case 8:
            return UIImage(named: "needHelp")
        default:
            return nil
        }
    }
    
    var categoryName: String? {
        switch self.newsCategoryId {
        case 1:
            return "Объявление"
        case 2:
            return "День рождения"
        case 3:
            return "Зарплата"
        case 4:
            return "Профсоюз"
        case 5:
            return "Праздник"
        case 6:
            return "Массаж"
        case 7:
            return "Благодарность"
        case 8:
            return "Нужна помощь"
        default:
            return nil
        }
    }
}

