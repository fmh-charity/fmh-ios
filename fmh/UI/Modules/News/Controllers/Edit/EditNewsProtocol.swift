//
//  EditNewsProtocol.swift
//  fmh
//
//  Created: 16.07.2022
//

import Foundation

// MARK: - EditNewsPresenterInput
protocol EditNewsPresenterInput: AnyObject {
    var news: News? { get set }
    
    func getNews(id: Int)
    func createNews(news: DTONews)
}

// MARK: - EditNewsPresenterOutput
protocol EditNewsPresenterOutput: AnyObject {
    var presenter: EditNewsPresenterInput? { get set }
    
    func updatedNews()
    func createdNews()
}

// MARK: - EditNewsViewControllerProtocol
protocol EditNewsViewControllerProtocol: BaseViewProtocol {
    
}
