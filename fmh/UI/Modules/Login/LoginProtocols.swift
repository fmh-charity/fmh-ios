//
//  LoginProtocols.swift
//  fmh
//
//  Created: 30.04.2022
//

import Foundation

// MARK: - ViewController
protocol LoginViewControllerDelegate: AnyObject {
    
}

// MARK: - Presenter
protocol LoginPresenterDelegate {
    
    func login(login: String, password: String, completion: @escaping (LoginError?) -> Void )
    
}
