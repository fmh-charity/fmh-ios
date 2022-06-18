//
//  AuthorizationPresenter.swift
//  fmh
//
//  Created: 10.05.2022
//

import Foundation
import Combine

final class AuthorizationPresenter {
    
    weak private var output: AuthorizationPresenterOutput?
    
    var interactor: AuthInteractorProtocol?
    
    private var anyCancellable = Set<AnyCancellable>()

    init(output: AuthorizationPresenterOutput) {
        self.output = output
    }
    
}

// MARK: - EnterPresenterInput
extension AuthorizationPresenter: AuthorizationPresenterInput {
    
    func login(login: String, password: String, completion: @escaping (UserInfo?, AuthorizationError?) -> Void ) {
        
        interactor?.login(login: login, password:  password) { userInfo, networkError in
            
            if let networkError = networkError {
                // TODO: Добавить расшифровку ошибок на русском. (AuthError)
                switch networkError.code {
                    case 401 :
                        return completion(nil, .unauthorized)
                    case 403 :
                        return completion(nil, .forbidden)
                    case -1001 :
                        return completion(nil, .requestTimedOut)
                    case -1004 :
                        return completion(nil, .notConnectToServer)
                    default:
                        return completion(nil, .requestError(networkError))
                }
            }
            
            if let userInfo = userInfo {
                completion(userInfo, nil)
            }
        }

    }
    
}
