//
//  NewsInteractor.swift
//  fmh
//
//  Created: 04.06.2022
//

import Foundation
import Combine

protocol NewsInteractorProtocol {
    func getAllNews(completion: @escaping ([News]?, APIError?) -> Void )
}


class NewsInteractor {
    
    private var repository: NewsRepositoryProtocol?
    private var anyCancellable = Set<AnyCancellable>()
    
    init(repository: NewsRepositoryProtocol?) {
        self.repository = repository
    }
 
}

// MARK: - AuthInteractorProtocol
extension NewsInteractor: NewsInteractorProtocol {
   
    func getAllNews(completion: @escaping ([News]?, APIError?) -> Void) {
        self.repository?.getAllNews()
            .sink { anyCompletion in
                switch anyCompletion {
                case .failure(let error):
                    return completion(nil, error)
                case .finished:
                    break
                }
            }
            receiveValue: { news in
                return completion(news, nil)
            }
            .store(in: &anyCancellable)
    }

}

