//
//  News.swift
//  fmh
//
//  Created: 05.06.2022
//

import UIKit

struct News {
    
    let createDate: Date
    let creatorId: Int
    let creatorName: String
    let description: String
    let id: Int
    let newsCategoryId: Int
    let publishDate: Date
    let publishEnabled: Bool
    let title: String
    
}

extension News {
    
    var categoryImg: UIImage? {
        switch self.newsCategoryId {
        case 1:
            return UIImage(named: "news.announcement")
        case 2:
            return UIImage(named: "news.birthday")
        case 3:
            return UIImage(named: "news.salary")
        case 4:
            return UIImage(named: "news.tradeUnion")
        case 5:
            return UIImage(named: "news.holiday")
        case 6:
            return UIImage(named: "иnews.massage")
        case 7:
            return UIImage(named: "news.gratitude")
        case 8:
            return UIImage(named: "news.needHelp")
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

