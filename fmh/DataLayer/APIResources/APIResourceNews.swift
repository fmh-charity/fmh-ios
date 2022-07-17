//
//  APIResourceNews.swift
//  fmh
//
//  Created: 03.06.2022
//

import Foundation

enum APIResourceNews {
    
    case getAllNews                         // <- Реестр всех новостей
    case createNews (news: DTONews)         // <- Создание новой новости
    case refreshNews (news: DTONews)        // <- Обновляет информацию по новости
    case getNews  (id: Int)                 // <- Возвращает полную информацию по новости
    case removeNews (id: Int)               // <- Удаление новости

    func resource<T: Decodable>() -> APIResource<T> {
        switch self {
            case .getAllNews:
                return APIResource(path: "news",
                                   method: .get)
            
            case .createNews(news: let news):
                return APIResource(path: "news",
                                   method: .post,
                                   body: DTONews(createDate: news.createDate, creatorId: news.creatorId, creatorName: news.creatorName, description: news.description, id: news.id, newsCategoryId: news.newsCategoryId, publishDate: news.publishDate, publishEnabled: news.publishEnabled, title: news.title))
            
            case .refreshNews(news: let news):
                return APIResource(path: "news",
                                   method: .put,
                                   body: news)
            
            case .getNews(id: let id):
                return APIResource(path: "news/\(id)",
                                   method: .get)
            
            case .removeNews(id: let id):
                return APIResource(path: "news/\(id)",
                                   method: .delete)
        }
    }
}

