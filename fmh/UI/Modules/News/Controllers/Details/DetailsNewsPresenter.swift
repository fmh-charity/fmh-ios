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

    func getAllNews() {
        interactor.getAllNews { news, apiError in
            guard apiError == nil else {  return }
            if let news = news {
                print("news count details: \(news.count)")
                DispatchQueue.main.async {
                    self.news = news
                }
            }
            
        }
    }
    
    func deleteNews(id: Int) {
        interactor.deleteNews(id: id)
    }

}
