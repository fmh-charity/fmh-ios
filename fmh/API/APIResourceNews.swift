//
//  APIResourceNews.swift
//  fmh
//
//  Created: 09.09.2022
//

import Foundation

/// Новости
struct APIResourceNews {
    
    /// Реестр всех новостей
    static func getAllNews(publishDate: Bool? = nil, elements: Int? = nil, pages: Int? = nil, newsCategoryId: Int? = nil, publishDateFrom: Date? = nil, publishDateTo: Date? = nil) -> APIResource<APIDTONewsList> {
        var parametrs: APIURLParameters  = [:]
        
        if let publishDate = publishDate { parametrs["publishDate"] = String(publishDate) }
        if let elements = elements { parametrs["elements"] = String(elements) }
        if let pages = pages { parametrs["pages"] = String(pages) }
        if let newsCategoryId = newsCategoryId { parametrs["newsCategoryId"] = String(newsCategoryId) }
        if let publishDateFrom = publishDateFrom { parametrs["publishDateFrom"] = publishDateFrom.toString() }
        if let publishDateTo = publishDateTo { parametrs["publishDateTo"] = publishDateTo.toString() }
        
        return APIResource(path: "/fmh/news",
                           parametrs: parametrs,
                           method: .get)
    }
    
    /// Создание новой новости
    static func createNews(news: APIDTONews) -> APIResource<APIDTONews> {
        APIResource(path: "/fmh/news",
                    method: .post,
                    body: news)
    }
    
    /// Обновляет информацию по новости
    static func updateNews(news: APIDTONews) -> APIResource<APIDTONews> {
        APIResource(path: "/fmh/news",
                    method: .put,
                    body: news)
    }
    
    /// Возвращает полную информацию по новости
    static func getNews(id: Int) -> APIResource<APIDTONews> {
        APIResource(path: "/fmh/news/\(id)",
                    method: .get)
    }
    
    /// Удаление новости
    static func delNews(id: Int) -> APIResource<APIDTONews> {
        APIResource(path: "/fmh/news/\(id)", method: .delete)
    }
    
}
