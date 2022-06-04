//
//  NewsRepository.swift
//  fmh
//
//  Created: 03.06.2022
//

import Foundation
import Combine

protocol NewsRepositoryProtocol {

    func getAllNews() -> AnyPublisher<[News], APIError>
    
}

class NewsRepository: Network {
    
    override init() {
        super.init()
    }
    
}

// MARK: - AuthRepositoryProtocol
extension NewsRepository: NewsRepositoryProtocol {
    
    func getAllNews() -> AnyPublisher<[News], APIError> {
        let resource = APIResourceNews.getAllNews
        return fetchDataPublisher(resource: resource.resource())
            .map { $0 }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
