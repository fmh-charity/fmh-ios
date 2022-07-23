//
//  MainScreenProtocol.swift
//  fmh
//
//  Created: 25.04.22

import UIKit

// MARK: - GeneralPresenterInput
protocol MainScreenPresenterInput: AnyObject {
    var news: [NewsViewModel] { get set }
    var wishes: [WishesViewModel] { get set }
    
    func getAllNews()
    func getAllWishes()
}

// MARK: - GeneralPresenterOutput
protocol MainScreenPresenterOutput: AnyObject {
    var presenter: MainScreenPresenterInput? { get set }
    
    func updatedNews()
    func createdNews()
}

// MARK: - GeneralViewControllerProtocol
protocol MainScreenViewControllerProtocol: BaseViewProtocol {
    
}

