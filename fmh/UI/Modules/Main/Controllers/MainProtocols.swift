//
//  MainProtocols.swift
//  fmh
//
//  Created: 10.05.2022
//

import Foundation

// MARK: - MainAssemblable
protocol MainAssemblable: MainViewProtocol, MainPresenterOutput {}

// MARK: - MainPresenterInput
protocol MainPresenterInput: AnyObject {
    
}

// MARK: - MainPresenterOutput
protocol MainPresenterOutput: AnyObject {
    var presenter: MainPresenterInput? { get set }
}

// MARK: - MainViewProtocol
protocol MainViewProtocol: NSObjectProtocol, Presentable {
    var onCompletion: CompletionBlock? { get set }
}
