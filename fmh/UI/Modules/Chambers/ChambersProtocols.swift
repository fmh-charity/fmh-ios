//
//  ChambersProtocols.swift
//  fmh
//
//  Created: 10.06.2022
//

import Foundation

// MARK: - ChambersPresenterInput

protocol ChambersPresenterInput: AnyObject {
    
}

// MARK: - ChambersPresenterOutput

protocol ChambersPresenterOutput: AnyObject {
    var presenter: ChambersPresenterInput? { get set }
}

// MARK: - ChambersViewControllerProtocol

protocol ChambersViewControllerProtocol: BaseViewProtocol {
    
}
