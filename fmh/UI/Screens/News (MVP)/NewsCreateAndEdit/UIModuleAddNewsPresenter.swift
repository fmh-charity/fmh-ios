//
//  UIModuleAddNewsPresenter.swift
//  fmh
//
//  Created: 16.07.2022
//

import Foundation

// MARK: - UIModuleAddNewsPresenterProtocol
protocol UIModuleAddNewsPresenterProtocol: AnyObject {
    var news: APIDTONews? { get set }
    var userInfo: APIURLSessionService.UserInfo? { get }
    func getNews(id: Int)
    func createNews(news: APIDTONews)
}

// MARK: - UIModuleAddNewsPresenterDelegate
protocol UIModuleAddNewsPresenterDelegate: AnyObject {
//    var presenter: UIModuleAddNewsPresenterProtocol? { get set }
    func updatedNews()
    func createdNews()
}


final class UIModuleAddNewsPresenter {

    weak private var view: UIModuleAddNewsPresenterDelegate?
    private let repository: APIRepositoryNewsProtocol

    var userInfo: APIURLSessionService.UserInfo?
    
    var news: APIDTONews? {
        didSet {
            view?.updatedNews()
        }
    }
    
    var createNews: APIDTONews? {
        didSet {
            view?.createdNews()
        }
    }
    
    init(repository: APIRepositoryNewsProtocol, view: UIModuleAddNewsPresenterDelegate, userInfo: APIURLSessionService.UserInfo?) {
        self.repository = repository
        self.view = view
        self.userInfo = userInfo
    }
}

// MARK: - EditNewsPresenterInput
extension UIModuleAddNewsPresenter: UIModuleAddNewsPresenterProtocol {
    
    func createNews(news: APIDTONews) {
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
