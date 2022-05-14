//
//  LoadingProtocols.swift
//  fmh
//
//  Created: 14.05.2022
//

import Foundation

// MARK: - LoadingAssemblable
protocol LoadingAssemblable: LoadingViewProtocol, LoadingPresenterOutput {}

// MARK: - LoadingPresenterInput
protocol LoadingPresenterInput: AnyObject {
    func isDisplayed()
}

// MARK: - LoadingPresenterOutput
protocol LoadingPresenterOutput: AnyObject {
    var presenter: LoadingPresenterInput? { get set }
    
    func hide()
}

// MARK: - LoadingViewProtocol
protocol LoadingViewProtocol: NSObjectProtocol, Presentable {
    var onCompletion: CompletionBlock? { get set }
}
