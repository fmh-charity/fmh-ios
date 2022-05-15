//
//  GeneralProtocols.swift
//  fmh
//
//  Created: 15.05.2022
//

import Foundation

// MARK: - GeneralPresenterInput
protocol GeneralPresenterInput: AnyObject {
    func getUserInfo ()
    func logOut ()
}


// MARK: - GeneralPresenterOutput
protocol GeneralPresenterOutput: AnyObject {
    var presenter: GeneralPresenterInput? { get set }
}

// MARK: - GeneralViewControllerDelegate
protocol GeneralViewControllerDelegate: AnyObject {
    func logOut ()
}
