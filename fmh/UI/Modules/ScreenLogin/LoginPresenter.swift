//
//  LoginPresenter.swift
//  fmh
//
//  Created: 30.04.2022
//

import UIKit
import SwiftUI
import Combine

class LoginPresenter {
    
    // MARK: - External vars
    weak var viewController: LoginViewControllerDelegate!
    
    // MARK: - Private vars
    private var repository: AuthRepositoryProtocol
    private var anyCancellable = Set<AnyCancellable>()
    
    init(repository: AuthRepositoryProtocol, viewController: LoginViewControllerDelegate) {
        self.viewController = viewController
        self.repository = repository
    }
    
}


// MARK: - HomeViewControllerDelegate
extension LoginPresenter: LoginPresenterDelegate {
    
    func login(login: String, password: String, completion: @escaping (AuthorizationError?) -> Void ) {
        
        repository.login(login: login, password: password)
            .sink { anyCompletion in
                switch anyCompletion {
                case .failure(let error):
                    // TODO: Добавить расшифровку ошибок на русском. (AuthError)
                    // Или весь перевод сделать в APIError
                    // Перенести в отдельный метод обработки (перевода ошибок)
                    switch error.code {
                        case 401 :
                            return completion(.unauthorized)
                        case 403 :
                            return completion(.forbidden)
                        case -1001 :
                            return completion(.requestTimedOut)
                        case -1004 :
                            return completion(.notConnectToServer)
                        default:
                        return completion(.requestError(error))
                    }
                case .finished:
                    return completion(nil)
                }
            } receiveValue: { _ in }
            .store(in: &anyCancellable)
    }
    
}
