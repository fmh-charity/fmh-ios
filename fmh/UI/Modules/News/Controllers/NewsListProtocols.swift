//
//  NewsProtocols.swift
//  fmh
//
//  Created: 06.06.2022
//

import Foundation

// MARK: - GeneralPresenterInput
protocol NewsListPresenterInput: AnyObject {
    var news: [News] { get set }
    
    func getAllNews(categoryId: Int?)
}

// MARK: - GeneralPresenterOutput
protocol NewsListPresenterOutput: AnyObject {
    var presenter: NewsListPresenterInput? { get set }
    
    func updatedNews()
}

// MARK: - GeneralViewControllerProtocol
protocol NewsListViewControllerProtocol: BaseViewProtocol {
    
}

protocol NewsListViewControllerDelegate: AnyObject {
    func filtering(categoryId: Int?, datePub: String)
}
