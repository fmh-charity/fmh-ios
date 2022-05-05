//
//  AuthProtocols.swift
//  fmh
//
//  Created: 30.04.2022
//

import Foundation

// MARK: - ViewController
protocol AuthViewControllerDelegate: AnyObject {
    
}

// MARK: - Presenter
protocol AuthPresenterDelegate {
    
    func login(login: String, password: String, completion: @escaping (Error?) -> Void )
    
}
