//
//  NewsInteractor.swift
//  fmh
//
//  Created: 04.06.2022
//

import Foundation
import Combine

protocol NewsInteractorProtocol {
    func getAllNews(completion: @escaping ([News]?, NetworkError?) -> Void )
    func getNews(id: Int, completion: @escaping (News?, NetworkError?) -> Void)
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
   
    func getAllNews(completion: @escaping ([News]?, NetworkError?) -> Void) {
        self.repository?.getAllNews()
            .sink { anyCompletion in
                switch anyCompletion {
                case .failure(let error):
                    return completion(nil, error)
                case .finished:
                    break
                }
            }
            receiveValue: { dtoNews in
                let news = dtoNews.map {
                    News(createDate: $0.createDate,
                         creatorId: $0.creatorId,
                         creatorName: $0.creatorName,
                         description: $0.description,
                         id: $0.id,
                         newsCategoryId: $0.newsCategoryId,
                         publishDate: $0.publishDate,
                         publishEnabled: $0.publishEnabled,
                         title: $0.title)
                }
                return completion(news, nil)
            }
            .store(in: &anyCancellable)
    }

    func getNews(id: Int, completion: @escaping (News?, NetworkError?) -> Void) {
        self.repository?.getNews(id: id)
            .sink { anyCompletion in
                switch anyCompletion {
                case .failure(let error):
                    return completion(nil, error)
                case .finished:
                    break
                }
            }
            receiveValue: { dtoNews in
                let news = News(createDate: dtoNews.createDate,
                                creatorId: dtoNews.creatorId,
                                creatorName: dtoNews.creatorName,
                                description: dtoNews.description,
                                id: dtoNews.id,
                                newsCategoryId: dtoNews.newsCategoryId,
                                publishDate: dtoNews.publishDate,
                                publishEnabled: dtoNews.publishEnabled,
                                title: dtoNews.title)
                return completion(news, nil)
            }
            .store(in: &anyCancellable)
    }
    
}

