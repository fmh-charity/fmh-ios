//
//  EditNewsPresenter.swift
//  fmh
//
//  Created: 16.07.2022
//

import Foundation

final class EditNewsPresenter {

    weak private var output: EditNewsPresenterOutput?
    
    var interactor: NewsInteractorProtocol

    var news: News? {
        didSet {
            output?.updatedNews()
        }
    }
    
    init(interactor: NewsInteractorProtocol, output: EditNewsPresenterOutput) {
        self.interactor = interactor
        self.output = output
    }
    
    
}

// MARK: - EditNewsPresenterInput
extension EditNewsPresenter: EditNewsPresenterInput {
    
    func createNews(news: DTONews) {
        interactor.createNews(news: news) { news, apiError in
            guard apiError == nil else {  return }
            
            if let news = news {
                print("Create news: \(news)")
                    self.news = news
            }
        }
    }
    

    func getNews(id: Int) {
        interactor.getNews(id: id) { news, apiError in
            guard apiError == nil else {  return }
            
            if let news = news {
                print("Get news: \(news.id)")
               // DispatchQueue.main.async {
                    self.news = news
              //  }
            }
            
        }
    }
    
    

}
