//
//  AuthorizationProtocols.swift
//  fmh
//
//  Created: 10.05.2022
//

import Foundation

// MARK: - AuthorizationAssemblable
protocol AuthorizationAssemblable: AuthorizationViewProtocol, AuthorizationPresenterOutput {}

// MARK: - AuthorizationPresenterInput
protocol AuthorizationPresenterInput: AnyObject {
    func login(login: String, password: String, completion: @escaping (AuthorizationError?) -> Void )
}

// MARK: - AuthorizationPresenterOutput
protocol AuthorizationPresenterOutput: AnyObject {
    var presenter: AuthorizationPresenterInput? { get set }
    
    func signInOk()
}

// MARK: - AuthorizationViewProtocol
protocol AuthorizationViewProtocol: NSObjectProtocol, Presentable {
    var onCompletion: CompletionBlock? { get set }
}
