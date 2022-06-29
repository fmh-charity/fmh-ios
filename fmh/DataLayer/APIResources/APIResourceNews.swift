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
                                   body: news)
            
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

