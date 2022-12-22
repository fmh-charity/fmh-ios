//
//  NewsDetailsPresenter.swift
//  fmh
//
//  Created: 12.06.2022
//

import Foundation

// MARK: - NewsDetailsPresenterProtocol

protocol NewsDetailsPresenterProtocol: AnyObject {
    var news: [DTONews] { get set }
    var totalPages: Int { get }
    var curentPage: Int { get set }
    var filter: FilterNews { get set }
    func tapOnFilter()
    func tapOnAddNews()
    func tapOnEditNews(newsId: Int, status: String)
    func getAllNews(page: Int?)
    func deleteNews(id: Int, index: Int)
}

// MARK: - NewsDetailsPresenterDelegate

protocol NewsDetailsPresenterDelegate: AnyObject {

    func updatedNews()
}

final class NewsDetailsPresenter {

    weak private var view: NewsDetailsPresenterDelegate?
    weak var coordinator: GeneralCoordinatorProtocol?
    private let repository: APIRepositoryNewsProtocol

    var totalPages = 0
    var curentPage = 0

    var news: [DTONews] = [] {
        didSet {
            view?.updatedNews()
        }
    }
    var filter = FilterNews()

    init(repository: APIRepositoryNewsProtocol, view: NewsDetailsPresenterDelegate) {
        self.repository = repository
        self.view = view
    }
}

// MARK: - DetailsNewsPresenterInput

extension NewsDetailsPresenter: NewsDetailsPresenterProtocol {
    func tapOnAddNews() {
        coordinator?.perfomScreenFlow(.addNews(), type: .push)
    }

    func tapOnEditNews(newsId: Int, status: String) {
        coordinator?.perfomScreenFlow(.addNews(idNews: newsId, transmitter: status), type: .push)
    }

    func tapOnFilter() {
        coordinator?.perfomScreenFlow(.filterNews(delegate: self), type: .present)
    }

    func getAllNews(page: Int?) {
        repository.getAllNews(
            publishDate: filter.sorted,
            elements: 13,
            pages: page,
            newsCategoryId: filter.newsCategoryId,
            publishDateFrom: filter.publishDateFrom,
            publishDateTo: filter.publishDateTo
        ) { news, error in
            guard error == nil else { return }
            if let news = news {
                self.news.append(contentsOf: news.elements)
                self.totalPages = news.pages
            }
        }
    }

    func deleteNews(id: Int, index: Int) {
        repository.delNews(id: id) { success, apiError in
            if success {
                print("delete done id \(id)")
                self.news.remove(at: index)
            }
            guard apiError == nil else { return }
        }
    }
}

extension NewsDetailsPresenter: FilterNewsDelegate {
    func filtering(filter: FilterNews?) {
        //totalPages = 0
        curentPage = 0
        guard let filter = filter else { return }
        self.filter = filter
        news.removeAll()
        getAllNews(page: curentPage)
    }
}

