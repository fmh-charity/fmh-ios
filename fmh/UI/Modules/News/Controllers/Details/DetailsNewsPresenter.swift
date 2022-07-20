//
//  DetailsNewsPresenter.swift
//  fmh
//
//  Created: 12.06.2022
//

import Foundation

final class DetailsNewsPresenter {

    weak private var output: DetailsNewsPresenterOutput?
    
    var interactor: NewsInteractorProtocol

    var news: [News] = [] {
        didSet {
//            news = news.filter({ news in
//                news.publishEnabled
//            })
            output?.updatedNews()
        }
    }
    
    init(interactor: NewsInteractorProtocol, output: DetailsNewsPresenterOutput) {
        self.interactor = interactor
        self.output = output
    }
    
}

// MARK: - DetailsNewsPresenterInput
extension DetailsNewsPresenter: DetailsNewsPresenterInput {

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
    
    func deleteNews(id: Int, index: Int) {
        interactor.deleteNews(id: id) { success, apiError in
            guard apiError == nil else {  return }
            if success {
                print("success delete news id \(id)")
                self.news.remove(at: index)
            }
        }
    }
}
