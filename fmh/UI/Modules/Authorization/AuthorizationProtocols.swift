//
//  AuthorizationProtocols.swift
//  fmh
//
//  Created: 10.05.2022
//

import Foundation


// MARK: - AuthorizationPresenterInput
protocol AuthorizationPresenterInput: AnyObject {
    func login(login: String, password: String, completion: @escaping (UserInfo?, AuthorizationError?) -> Void )
}


// MARK: - AuthorizationPresenterOutput
protocol AuthorizationPresenterOutput: AnyObject {
    var presenter: AuthorizationPresenterInput? { get set }
}

// MARK: - AuthorizationViewControllerProtocol
protocol AuthorizationViewControllerProtocol: BaseViewProtocol {
    
}
