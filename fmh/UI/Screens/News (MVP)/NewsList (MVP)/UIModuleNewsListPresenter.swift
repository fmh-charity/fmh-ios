//
//  NewsListPresenter.swift
//  fmh
//
//  Created: 06.06.2022
//

import Foundation

protocol NewsListPresenterProtocol {
    var news: [DTONews] { get set }
    var pages: Int { get }
    var isAdmin: Bool { get }
    func tapOnDetails()
    func tapOnfilters()
    func getAllNews(filter: FilterNews?, page: Int?)
}

protocol NewsListPresenterDelegate: AnyObject {
    func updatedNews()
}

final class UIModuleNewsListPresenter {

    weak private var view: NewsListPresenterDelegate?
    private let repository: APIRepositoryNewsProtocol
    var router: UICoordinatorGeneralTransitions
    var isAdmin: Bool

    var pages: Int = 0
    
    var news: [DTONews] = [] {
        didSet {
            view?.updatedNews()
        }
    }
    
    init(repository: APIRepositoryNewsProtocol, view: NewsListPresenterDelegate, router: UICoordinatorGeneralTransitions, isAdmin: Bool) {
        self.router = router
        self.repository = repository
        self.view = view
        self.isAdmin = isAdmin
    }
}

extension UIModuleNewsListPresenter: NewsListPresenterProtocol {

    func tapOnDetails() {
        router.goToViewcontrollerByPath("/news/details")
    }
    
    func tapOnfilters() {
        router.goToViewcontrollerByPath("/news/filter", arguments: ["delegateFilterNews" : view as Any])
        print(#function)
    }

    func getAllNews(filter: FilterNews?, page: Int?) {
        repository.getAllNews(
            publishDate: filter?.sorted,
            elements: 12,
            pages: page,
            newsCategoryId: filter?.newsCategoryId,
            publishDateFrom: filter?.publishDateFrom,
            publishDateTo: filter?.publishDateTo
        ){ news, error in
            guard error == nil else { return }
            if let news = news {
                self.news.append(contentsOf: news.elements)
                self.pages = news.pages
            }
        }
    }
}

