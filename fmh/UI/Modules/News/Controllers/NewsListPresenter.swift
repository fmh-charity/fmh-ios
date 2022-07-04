//
//  NewsPresenter.swift
//  fmh
//
//  Created: 06.06.2022
//

import Foundation

final class NewsListPresenter {

    weak private var output: NewsListPresenterOutput?
    
    let interactor: NewsInteractorProtocol

    var news: [News] = [] {
        didSet {
            output?.updatedNews()
        }
    }
    
    init(interactor: NewsInteractorProtocol, output: NewsListPresenterOutput) {
        self.interactor = interactor
        self.output = output
    }
    
    
}

// MARK: - GeneralPresenterInput
extension NewsListPresenter: NewsListPresenterInput {

    func getAllNews() {
        interactor.getAllNews { news, apiError in
            guard apiError == nil else {  return }
            
            if let news = news {
                print("news count: \(news.count)")
                DispatchQueue.main.async {
                    self.news = news
                }
            }
            
        }
    }

}
