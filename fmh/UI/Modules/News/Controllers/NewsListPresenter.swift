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

    func getAllNews(categoryId: Int?) {
        interactor.getAllNews { news, apiError in
            guard apiError == nil else {  return }
            if let news = news {
                print("news count details: \(news.count)")
                //DispatchQueue.main.async {
                if let id = categoryId {
                    self.news = news.filter({ item in
                        item.newsCategoryId == id
                    })
                } else {
                    self.news = news
                }
            }
        }
    }

}
