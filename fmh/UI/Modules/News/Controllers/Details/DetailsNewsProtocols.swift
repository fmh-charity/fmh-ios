//
//  DetailsNewsProtocols.swift
//  fmh
//
//  Created: 12.06.2022
//

import Foundation

// MARK: - DetailsNewsPresenterInput
protocol DetailsNewsPresenterInput: AnyObject {
    var news: [News] { get set }
    
    func getAllNews(filters: [FilterNews?])
    func deleteNews(id: Int, index: Int)
}

// MARK: - DetailsNewsPresenterOutput
protocol DetailsNewsPresenterOutput: AnyObject {
    var presenter: DetailsNewsPresenterInput? { get set }
    
    func updatedNews()
}

// MARK: - DetailsNewsViewControllerProtocol
protocol DetailsNewsViewControllerProtocol: BaseViewProtocol {
    
}

protocol DetailsNewsViewControllerDelegate: NewsListViewControllerDelegate {
    //func filtering(categoryId: Int?, datePub: String)

}


