//
//  NewsListPresenter.swift
//  fmh
//
//  Created: 06.06.2022
//

import Foundation

protocol NewsListPresenterProtocol {
    var news: [DTONews] { get set }
    var totalPages: Int { get }
    var curentPage: Int { get set }
    var isAdmin: Bool { get }
    var filter: FilterNews { get set }

    func tapOnDetails()
    func tapOnFilters()
    func getAllNews(page: Int?)
}

protocol NewsListPresenterDelegate: AnyObject {
    func updatedNews()
}

final class NewsListPresenter {

    weak private var view: NewsListPresenterDelegate?
    private let repository: APIRepositoryNewsProtocol
    weak var coordinator: GeneralCoordinatorProtocol?
    var isAdmin: Bool
    var totalPages = 0
    var curentPage = 0

    var news: [DTONews] = [] {
        didSet {
            view?.updatedNews()
        }
    }

    var filter = FilterNews()
    
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
        coordinator?.perfomScreenFlow(.filterNews(delegate: self), type: .present)
        print(#function)
    }

    func getAllNews(page: Int?) {
        repository.getAllNews(
            publishDate: filter.sorted,
            elements: 12,
            pages: page,
            newsCategoryId: filter.newsCategoryId,
            publishDateFrom: filter.publishDateFrom,
            publishDateTo: filter.publishDateTo
        ){ news, error in
            guard error == nil else { return }
            if let news = news {
                self.news.append(contentsOf: news.elements)
                self.totalPages = news.pages
            }
        }
    }
}

extension NewsListPresenter: FilterNewsDelegate {
    func filtering(filter: FilterNews?) {
        curentPage = 0
        guard let filter = filter else { return }
        self.filter = filter
        news.removeAll()
        getAllNews(page: curentPage)
    }
}

