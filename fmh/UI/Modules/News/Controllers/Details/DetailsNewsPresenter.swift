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
