//
//  NewsListPresenter.swift
//  fmh
//
//  Created: 14.06.2022
//

import UIKit

final class NewsListPresenter {

    let interactor: NewsInteractorProtocol
    
    weak private var output: NewsListPresenterOutput?

    init(interactor: NewsInteractorProtocol, output: NewsListPresenterOutput) {
        self.interactor = interactor
        self.output = output
    }
    
}

// MARK: - LoadingPresenterInput
extension NewsListPresenter: NewsListPresenterInput {
    
    func getNews(_ completion: @escaping ([News]?) -> ()) {
        interactor.getAllNews { news, networkError in
            
            //TODO: Обработку ошибок добавить
            guard networkError == nil else {
                completion(nil)
                return
            }
            
            if let news = news {
                let filterNews = news.filter{ $0.publishEnabled && $0.publishDate <= Date() }
                completion(news) // <- filterNews передавать потом (щас дата там 53 год)
                return
            }
        }
    }
    
}
