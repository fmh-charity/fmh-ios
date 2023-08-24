//
//  AuthorizationPresenter.swift
//  
//
//  Created by Константин Туголуков on 21.08.2023.
//

import Foundation

protocol AuthorizationPresenterProtocol {
    
}

protocol AuthorizationPresenterDelegate: AnyObject {
    
}

// MARK: - AuthorizationPresenter

final class AuthorizationPresenter {
    
    // Dependences
    weak var delegate: AuthorizationPresenterDelegate?
    
    // MARK: Life cycle
    init() {
        
    }
}

// MARK: - AuthorizationPresenterProtocol

extension AuthorizationPresenter: AuthorizationPresenterProtocol {

}
