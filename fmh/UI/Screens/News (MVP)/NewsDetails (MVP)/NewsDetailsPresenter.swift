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
    var pages: Int { get }
    func tapOnFilter()
    func tapOnAddNews()
    func tapOnEditNews(newsId: Int, status: String)
    func getAllNews(filter: FilterNews?, page: Int?)
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

    var pages: Int = 0

    var news: [DTONews] = [] {
        didSet {
            view?.updatedNews()
        }
    }

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
        //router.goToViewcontrollerByPath("/news/addNews", arguments: ["newsId" : newsId, "destinationName": status])
    }

    func tapOnFilter() {
        coordinator?.perfomScreenFlow(.filterNews, type: .present)
    }

    func getAllNews(filter: FilterNews?, page: Int?) {
        repository.getAllNews(
            publishDate: filter?.sorted,
            elements: 12,
            pages: page,
            newsCategoryId: filter?.newsCategoryId,
            publishDateFrom: filter?.publishDateFrom,
            publishDateTo: filter?.publishDateTo
        ) { news, error in
            guard error == nil else { return }
            if let news = news {
                self.news.append(contentsOf: news.elements)
                self.pages = news.pages
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
