//
//  NewsRepository.swift
//  fmh
//
//  Created: 03.06.2022
//

import Foundation
import Combine

protocol NewsRepositoryProtocol {

    func getAllNews() -> AnyPublisher<[DTONews], NetworkError>
    func getNews(id: Int) -> AnyPublisher<DTONews, NetworkError>
    func deleteNews(id: Int)
}

class NewsRepository: Network {
    
    override init() {
        super.init()
    }
    
}

// MARK: - AuthRepositoryProtocol
extension NewsRepository: NewsRepositoryProtocol {
    
    func getAllNews() -> AnyPublisher<[DTONews], NetworkError> {
        let resource = APIResourceNews.getAllNews
        return fetchDataPublisher(resource: resource.resource())
            .map { $0 }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getNews(id: Int) -> AnyPublisher<DTONews, NetworkError> {
        let resource = APIResourceNews.getNews(id: id)
        return fetchDataPublisher(resource: resource.resource())
            .map { $0 }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func deleteNews(id: Int) {
        let resource = APIResourceNews.removeNews(id: id)
    }
    
}
