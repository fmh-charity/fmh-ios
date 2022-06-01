//
//  TemplateProtocols.swift
//  fmh
//
//  Created: 25.05.2022
//

import Foundation

// MARK: - GeneralPresenterInput
protocol TemplatePresenterInput: AnyObject {

}

// MARK: - GeneralPresenterOutput
protocol TemplatePresenterOutput: AnyObject {
    var presenter: TemplatePresenterInput? { get set }
}

// MARK: - TemplateViewControllerProtocol
protocol TemplateViewControllerProtocol: BaseViewProtocol {
    
}
