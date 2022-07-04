//
//  DetailsNewsProtocols.swift
//  fmh
//
//  Created: 12.06.2022
//

import Foundation

// MARK: - DetailsNewsPresenterInput
protocol DetailsNewsPresenterInput: AnyObject {
    var news: [News] { get }
    
    func getAllNews()
}

// MARK: - DetailsNewsPresenterOutput
protocol DetailsNewsPresenterOutput: AnyObject {
    var presenter: DetailsNewsPresenterInput? { get set }
    
    func updatedNews()
}

// MARK: - DetailsNewsViewControllerProtocol
protocol DetailsNewsViewControllerProtocol: BaseViewProtocol {
    
}
