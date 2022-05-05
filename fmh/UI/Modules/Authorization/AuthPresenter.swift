//
//  AuthPresenter.swift
//  fmh
//
//  Created: 30.04.2022
//

import UIKit
import SwiftUI

class AuthPresenter {
    
    // MARK: - External vars
    weak var viewController: AuthViewControllerDelegate!
    
    // MARK: - Private vars
    private var repository: AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol, viewController: AuthViewControllerDelegate) {
        self.viewController = viewController
        self.repository = repository
    }
    
}


// MARK: - HomeViewControllerDelegate
extension AuthPresenter: AuthPresenterDelegate {
    
    func login(login: String, password: String, completion: @escaping (AuthError?) -> Void ) {
        repository.login(login: login, password: password) { result in
            switch result {
            case .success(let tokenData):
                completion(nil)
                // Переброс на другой экран
            case .failure(let error):
                // TODO: Добавить расшифровку ошибок на русском. (AuthError)
                switch error.code {
                    case 401 :
                        completion(.unauthorized)
                    case 403 :
                        completion(.forbidden)
                    case -1001 :
                        completion(.requestTimedOut)
                    default:
                        completion(.requestError(error))
                }
            }
        }
    }
 
}
