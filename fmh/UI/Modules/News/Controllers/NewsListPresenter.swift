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

    func getAllNews(filters: [FilterNews?]) {
        interactor.getAllNews { news, apiError in
            guard apiError == nil else {  return }
            if let news = news {
                print("filters presenter: \(filters)")
                    self.news = news.filter({ item in
                        var result = true
                        for filter in filters {
                            guard let filter = filter else { return true }
                            print("filters compare: \(filter)")
                            if !filter.compare(with: item) {
                                result = false
                            }
                        }
                        return result
                    })
                
            }
        }
    }
}
