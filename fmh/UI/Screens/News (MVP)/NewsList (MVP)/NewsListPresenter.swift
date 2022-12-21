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
    func tapOnFilters()
    func getAllNews(filter: FilterNews?, page: Int?)
}

protocol NewsListPresenterDelegate: AnyObject {
    func updatedNews()
}

final class NewsListPresenter {

    weak private var view: NewsListPresenterDelegate?
    private let repository: APIRepositoryNewsProtocol
    weak var coordinator: GeneralCoordinatorProtocol?
    var isAdmin: Bool

    var pages: Int = 0
    
    var news: [DTONews] = [] {
        didSet {
            view?.updatedNews()
        }
    }
    
    init(repository: APIRepositoryNewsProtocol, view: NewsListPresenterDelegate, isAdmin: Bool) {

        self.repository = repository
        self.view = view
        self.isAdmin = isAdmin
    }
}

extension NewsListPresenter: NewsListPresenterProtocol {

    func tapOnDetails() {
        coordinator?.perfomScreenFlow(.newsDetails, type: .push)
    }
    
    func tapOnFilters() {
        //router.goToViewcontrollerByPath("/news/filter", arguments: ["delegateFilterNews" : view as Any])
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

