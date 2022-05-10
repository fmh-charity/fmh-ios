//
//  AuthorizationPresenter.swift
//  fmh
//
//  Created: 10.05.2022
//

import Foundation
import Combine

final class AuthorizationPresenter {

    weak var output: AuthorizationPresenterOutput?
    
    // MARK: - Private vars
    private var repository: AuthRepositoryProtocol?
    private var anyCancellable = Set<AnyCancellable>()
    
    init(repository: AuthRepositoryProtocol?) {
        self.repository = repository
    }
    
    func handleSuccessSignIn() {
        output?.signInOk()
    }
}

// MARK: - EnterPresenterInput
extension AuthorizationPresenter: AuthorizationPresenterInput {
    
    func login(login: String, password: String, completion: @escaping (AuthorizationError?) -> Void ) {
        
        repository?.login(login: login, password: password)
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
                    self.handleSuccessSignIn()
                    return completion(nil)
                }
            } receiveValue: { _ in }
            .store(in: &anyCancellable)
    }

    
}
