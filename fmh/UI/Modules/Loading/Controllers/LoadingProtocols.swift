//
//  LoadingProtocols.swift
//  fmh
//
//  Created: 14.05.2022
//

import Foundation


// MARK: - LoadingPresenterInput
protocol LoadingPresenterInput: AnyObject {
    func isDisplayed()
}


// MARK: - LoadingPresenterOutput
protocol LoadingPresenterOutput: AnyObject {
    var presenter: LoadingPresenterInput? { get set }
    
    func hide()
}

// MARK: - LoadingViewControllerProtocol
protocol LoadingViewControllerProtocol: BaseViewProtocol {
    
}
