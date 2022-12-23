//
//  AddNewsPresenter.swift
//  fmh
//
//  Created: 16.07.2022
//

import Foundation

// MARK: - AddNewsPresenterProtocol
protocol AddNewsPresenterProtocol: AnyObject {
    var news: DTONews? { get set }
    var userInfo: APIClient.UserProfile? { get }
    func getNews(id: Int)
    func createNews(news: DTONews)
}

// MARK: - AddNewsPresenterDelegate
protocol AddNewsPresenterDelegate: AnyObject {

    func updatedNews()
    func createdNews()
}


final class AddNewsPresenter {

    weak private var view: AddNewsPresenterDelegate?
    private let repository: APIRepositoryNewsProtocol

    var userInfo: APIClient.UserProfile?

    var news: DTONews? {
        didSet {
            view?.updatedNews()
        }
    }

    var createNews: DTONews? {
        didSet {
            view?.createdNews()
        }
    }

    init(repository: APIRepositoryNewsProtocol, view: AddNewsPresenterDelegate, userInfo: APIClient.UserProfile?) {
        self.repository = repository
        self.view = view
        self.userInfo = userInfo
    }
}

// MARK: - EditNewsPresenterInput
extension AddNewsPresenter: AddNewsPresenterProtocol {

    func createNews(news: DTONews) {
        repository.createNews(news: news) { news, apiError in
            guard apiError == nil else { return }

            if let news = news {
                print("Create news: \(news)")
                    self.createNews = news
            }
        }
    }


    func getNews(id: Int) {
        repository.getNews(id: id) { news, apiError in
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
