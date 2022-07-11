//  
//  MainScreenProtocol.swift
//  fmh
//
//  Created: 25.04.22
//Muad8824diB

import UIKit

// MARK: - GeneralPresenterInput
protocol MainScreenPresenterInput: AnyObject {
//    func getUserInfo(completion: @escaping (UserInfo?, NetworkError?) -> Void)
}

// MARK: - GeneralPresenterOutput
protocol MainScreenPresenterOutput: AnyObject {
    var presenter: MainScreenPresenterInput? { get set }
}

// MARK: - GeneralViewControllerProtocol
protocol MainScreenViewControllerProtocol: BaseViewProtocol {
    
}
