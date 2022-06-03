//
//  NewsRepository.swift
//  fmh
//
//  Created: 03.06.2022
//

import Foundation
import Combine

protocol NewsRepositoryProtocol {
    
//    func login(login: String, password: String) -> AnyPublisher<TokenData, APIError>
//    func refresh(_ refreshToken: String) -> AnyPublisher<TokenData, APIError>
//    func userInfo() -> AnyPublisher<UserInfo, APIError>
    
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
