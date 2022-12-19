//
//  NewsRepository.swift
//  fmh
//
//  Created: 09.09.2022
//

import Foundation

/// Cервис для работы с новостями
protocol APIRepositoryNewsProtocol {
    /// Реестр всех новостей
    func getAllNews(publishDate: Bool?, elements: Int?, pages: Int?, newsCategoryId: Int?, publishDateFrom: Date?, publishDateTo: Date?, completion: @escaping (DTONewsList?, Error?) -> ())
    /// Создание новой новости
    func createNews(news: DTONews, completion: @escaping (DTONews?, Error?) -> ())
    /// Обновляет информацию по новости
    func updateNews(news: DTONews, completion: @escaping (DTONews?, Error?) -> ())
    /// Возвращает полную информацию по новости
    func getNews(id: Int, completion: @escaping (DTONews?, Error?) -> ())
    /// Удаление новости
    func delNews(id: Int, completion: @escaping (Bool, Error?) -> ())
}


/// Cервис для работы с новостями
class APIRepositoryNews {
    
    private let apiClient: APIServiceProtocol
    
    init(apiClient: APIServiceProtocol) {
        self.apiClient = apiClient
    }
    
    
}


//MARK: - APIRepositoryNewsProtocol
extension APIRepositoryNews: APIRepositoryNewsProtocol {
    
    /// Реестр всех новостей
    func getAllNews(
        publishDate: Bool? = nil,
        elements: Int? = nil,
        pages: Int? = nil,
        newsCategoryId: Int? = nil,
        publishDateFrom: Date? = nil,
        publishDateTo: Date? = nil,
        completion: @escaping (DTONewsList?, Error?) -> ()) {
            let resource = APIResourceNews.getAllNews(publishDate: publishDate, elements: elements, pages: pages, newsCategoryId: newsCategoryId, publishDateFrom: publishDateFrom, publishDateTo: publishDateTo)
            apiClient.fetch(request: <#T##URLRequest?#>) { data, _, error in
                guard error == nil else { return completion(nil, error) }
                if let decodeData = data {

                    return completion(decodeData, error)
                }
                return completion(nil, error)
            }
            service.fetchData(resource) { decodeData, _, error in
            guard error == nil else { return completion(nil, error) }
            if let decodeData = decodeData {
                return completion(decodeData, error)
            }
            return completion(nil, error)
        }
    }
    
    /// Создание новой новости
    func createNews(news: DTONews, completion: @escaping (DTONews?, Error?) -> ()) {
        let resource = APIResourceNews.createNews(news: news)
        service.fetchData(resource) { decodeData, _, error in
            guard error == nil else { return completion(nil, error) }
            if let decodeData = decodeData {
                return completion(decodeData, error)
            }
            return completion(nil, error)
        }
    }
    
    /// Обновляет информацию по новости
    func updateNews(news: DTONews, completion: @escaping (DTONews?, Error?) -> ()) {
        let resource = APIResourceNews.updateNews(news: news)
        service.fetchData(resource) { decodeData, _, error in
            guard error == nil else { return completion(nil, error) }
            if let decodeData = decodeData {
                return completion(decodeData, error)
            }
            return completion(nil, error)
        }
    }
    
    /// Возвращает полную информацию по новости
    func getNews(id: Int, completion: @escaping (DTONews?, Error?) -> ()) {
        let resource = APIResourceNews.getNews(id: id)
        service.fetchData(resource) { decodeData, _, error in
            guard error == nil else { return completion(nil, error) }
            if let decodeData = decodeData {
                return completion(decodeData, error)
            }
            return completion(nil, error)
        }
    }
    
    /// Удаление новости
    func delNews(id: Int, completion: @escaping (Bool, Error?) -> ()) {
        let resource = APIResourceNews.delNews(id: id)
        service.fetchData(resource) { _, response, error in
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                return completion(true, error)
            }
            guard error == nil else { return completion(false, error) }
            return completion(false, error)
        }
    }
    
}


