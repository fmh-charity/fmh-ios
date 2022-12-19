//
//  UIModuleNewsDetailsPresenter.swift
//  fmh
//
//  Created: 12.06.2022
//

import Foundation

// MARK: - UIModuleNewsDetailsPresenterProtocol
protocol UIModuleNewsDetailsPresenterProtocol: AnyObject {
    var news: [APIDTONews] { get set }
    var pages: Int { get }
    func tapOnFilter()
    func tapOnAddNews()
    func tapOnEditNews(newsId: Int, status: String)
    func getAllNews(filter: FilterNews?, page: Int?)
    func deleteNews(id: Int, index: Int)
}

// MARK: - UIModuleNewsDetailsPresenterDelegate
protocol UIModuleNewsDetailsPresenterDelegate: AnyObject {
    
    func updatedNews()
}

final class UIModuleNewsDetailsPresenter {

    weak private var view: UIModuleNewsDetailsPresenterDelegate?
    
    private let repository: APIRepositoryNewsProtocol
    private let router: UICoordinatorGeneralTransitions
    var pages: Int = 0

    var news: [APIDTONews] = [] {
        didSet {
            view?.updatedNews()
        }
    }
    
    init(repository: APIRepositoryNewsProtocol, view: UIModuleNewsDetailsPresenterDelegate, router: UICoordinatorGeneralTransitions) {
        self.repository = repository
        self.router = router
        self.view = view
    }
    
}

// MARK: - DetailsNewsPresenterInput
extension UIModuleNewsDetailsPresenter: UIModuleNewsDetailsPresenterProtocol {
    func tapOnAddNews() {
        router.goToViewcontrollerByPath("/news/addNews")
    }
    
    func tapOnEditNews(newsId: Int, status: String) {
        print(newsId, status)
        router.goToViewcontrollerByPath("/news/addNews", arguments: ["newsId" : newsId, "destinationName": status])
    }
    
    func tapOnFilter() {
        router.goToViewcontrollerByPath("/news/filter", arguments: ["delegateFilterNews" : view as Any])
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
