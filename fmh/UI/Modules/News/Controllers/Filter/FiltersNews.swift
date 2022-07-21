//
//  FiltersNews.swift
//  fmh
//
//  Created: 21.07.2022
//

import Foundation

enum FilterNews {
    case category(categoryId: Int?)
    case datePublish(datePublish: String?)

    func compare(with news: News) -> Bool {
        switch self {
        case .category(let category):
            guard let category = category else { return true }
            print(category, "and", news.newsCategoryId)
            return category == news.newsCategoryId
        case .datePublish(let datePublish):
            guard let datePublish = datePublish else { return true }
            print(datePublish, "and", news.publishDate.toString())
            return datePublish == news.publishDate.toString()
        }
    }
}
