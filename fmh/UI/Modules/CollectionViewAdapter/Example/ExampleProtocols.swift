//
//  ExampleProtocols.swift
//  fmh
//
//  Created: 30.05.2022
//

import Foundation

// MARK: - ExamplePresenterInput
protocol ExamplePresenterInput: AnyObject {

}

// MARK: - ExamplePresenterOutput
protocol ExamplePresenterOutput: AnyObject {
    var presenter: ExamplePresenterInput? { get set }
}

// MARK: - ExampleViewControllerProtocol
protocol ExampleViewControllerProtocol: BaseViewProtocol {
    
}
