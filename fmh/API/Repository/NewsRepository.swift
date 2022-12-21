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

            var parametrs: HTTPQuery = [:]

            if let publishDate = publishDate { parametrs["publishDate"] = String(publishDate) }
            if let elements = elements { parametrs["elements"] = String(elements) }
            if let pages = pages { parametrs["pages"] = String(pages) }
            if let newsCategoryId = newsCategoryId { parametrs["newsCategoryId"] = String(newsCategoryId) }
            if let publishDateFrom = publishDateFrom { parametrs["publishDateFrom"] = publishDateFrom.toString() }
            if let publishDateTo = publishDateTo { parametrs["publishDateTo"] = publishDateTo.toString() }

            guard let request = try? URLRequest(path: "/api/fmh/news", query: parametrs) else { return }
            
            apiClient.fetchData(request: request) { decodeData, _, error in

                return completion(decodeData, error)
            }
    }
    
    /// Создание новой новости
    func createNews(news: DTONews, completion: @escaping (DTONews?, Error?) -> ()) {

        guard let request = try? URLRequest( .POST, path: "/api/fmh/news", body: JSONEncoder().encode(news)) else { return }
        apiClient.fetchData(request: request) { decodeData, _, error in

            return completion(decodeData, error)
        }
    }

    /// Обновляет информацию по новости
    func updateNews(news: DTONews, completion: @escaping (DTONews?, Error?) -> ()) {

        guard let request = try? URLRequest( .PUT, path: "/api/fmh/news", body: JSONEncoder().encode(news)) else { return }
        apiClient.fetchData(request: request) { decodeData, _, error in

            return completion(decodeData, error)
        }
    }

    /// Возвращает полную информацию по новости
    func getNews(id: Int, completion: @escaping (DTONews?, Error?) -> ()) {

        var parametrs: HTTPQuery = [:]
        parametrs["id"] = String(id)

        guard let request = try? URLRequest( .GET, path: "/api/fmh/news/", query: parametrs) else { return }
        apiClient.fetchData(request: request) { decodeData, _, error in

            return completion(decodeData, error)
        }
    }

    /// Удаление новости
    func delNews(id: Int, completion: @escaping (Bool, Error?) -> ()) {

        var parametrs: HTTPQuery = [:]
        parametrs["id"] = String(id)

        guard let request = try? URLRequest( .DELETE, path: "/api/fmh/news/", query: parametrs) else { return }
        apiClient.fetch(request: request) { _, response, error in
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                return completion(true, error)
            }
            guard error == nil else { return completion(false, error) }
            return completion(false, error)
        }
    }
    
}


