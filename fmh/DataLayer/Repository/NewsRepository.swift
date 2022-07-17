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
    func deleteNews(id: Int) -> AnyPublisher<Bool, NetworkError>
}

class NewsRepository: Network {
    
    private var anyCancellable = Set<AnyCancellable>()
    
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
    
    func deleteNews(id: Int) -> AnyPublisher<Bool, NetworkError> {
            let resource = APIResourceNews.removeNews(id: id)
            return fetchDataPublisher(resource: resource.resource())
                .map { $0 }
                .catch({ networkError -> AnyPublisher<Bool, NetworkError> in
                    switch networkError {
                        case .JSONDecoderError(_):
                            return Just(true)   // <- Если дошло до декодирования значит норм все - выдаем "TRUE"
                                .setFailureType(to: NetworkError.self)
                                .eraseToAnyPublisher()
                    default:
                        return Fail<Bool, NetworkError>(error: networkError)   // <- Во всех остальных случаях- выдаем "FALSE"
                            .eraseToAnyPublisher()
                    }
                })
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
}
