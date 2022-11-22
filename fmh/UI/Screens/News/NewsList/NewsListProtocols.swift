//
//  NewsListProtocols.swift
//  fmh
//
//  Created: 14.06.2022
//

import Foundation

// MARK: - NewsListPresenterInput
protocol NewsListPresenterInput: AnyObject {
    func getNews(_ completion: @escaping ([News]?) -> ())
}


// MARK: - NewsListPresenterOutput
protocol NewsListPresenterOutput: AnyObject {
    var presenter: NewsListPresenterInput? { get set }
    
}

// MARK: - NewsListViewControllerProtocol
protocol NewsListViewControllerProtocol: BaseViewProtocol {
    
}
