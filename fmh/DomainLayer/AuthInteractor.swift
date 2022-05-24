//
//  AuthInteractor.swift
//  fmh
//
//  Created: 15.05.2022
//

import Foundation
import Combine

protocol AuthInteractorProtocol {
    func login(login: String, password: String, completion: @escaping (UserInfo?, APIError?) -> Void )
    func getUserInfo(completion: @escaping (UserInfo?, APIError?) -> Void )
<<<<<<< HEAD
}

=======
    func logOut()
}


>>>>>>> develop
class AuthInteractor {
    
    private var repository: AuthRepositoryProtocol?
    private var anyCancellable = Set<AnyCancellable>()
    
    init(repository: AuthRepositoryProtocol?) {
        self.repository = repository
    }
 
}

// MARK: - AuthInteractorProtocol
extension AuthInteractor: AuthInteractorProtocol {
    
    func login(login: String, password: String, completion: @escaping (UserInfo?, APIError?) -> Void ) {
        
        repository?.login(login: login, password: password)
            .sink { [unowned self] anyCompletion in
                switch anyCompletion {
                    case .failure(let error):
                        return completion(nil, error)
                    case .finished:
                        /// Get userInfo
                        self.repository?.userInfo()
                            .sink { _ in }
                                receiveValue: { userInfo in
                                    AppSession.userInfo = userInfo
                                    return completion(userInfo, nil)
                                }
                            .store(in: &anyCancellable)
                }
            } receiveValue: { tokenData in
                AppSession.tokens = tokenData
            }
            .store(in: &anyCancellable)
    }
    
    func getUserInfo(completion: @escaping (UserInfo?, APIError?) -> Void) {
        self.repository?.userInfo()
            .sink { anyCompletion in
                switch anyCompletion {
                case .failure(let error):
                    return completion(nil, error)
                case .finished:
                    break
                }
            }
            receiveValue: { userInfo in
                return completion(userInfo, nil)
            }
            .store(in: &anyCancellable)
    }
    
<<<<<<< HEAD
=======
    func logOut() {
        AppSession.logOut()
    }
    
>>>>>>> develop
}
