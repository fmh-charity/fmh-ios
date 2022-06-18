//
//  AuthInteractor.swift
//  fmh
//
//  Created: 15.05.2022
//

import Foundation
import Combine

protocol AuthInteractorProtocol {
    func login(login: String, password: String, completion: @escaping (UserInfo?, NetworkError?) -> Void )
    func getUserInfo(completion: @escaping (UserInfo?, NetworkError?) -> Void )
}

class AuthInteractor {
    
    private var repository: AuthRepositoryProtocol?
    private var anyCancellable = Set<AnyCancellable>()
    
    init(repository: AuthRepositoryProtocol?) {
        self.repository = repository
    }
 
}

// MARK: - AuthInteractorProtocol
extension AuthInteractor: AuthInteractorProtocol {
   
    func login(login: String, password: String, completion: @escaping (UserInfo?, NetworkError?) -> Void ) {
        
        repository?.login(login: login, password: password)
            .sink { [unowned self] anyCompletion in
                switch anyCompletion {
                    case .failure(let error):
                        return completion(nil, error)
                    case .finished:
                        /// Get userInfo
                        self.repository?.userInfo()
                            .sink { _ in }
                                receiveValue: { dtoUserInfo in
                                    AppSession.userInfo = dtoUserInfo
                                    let userInfo = UserInfo(admin: dtoUserInfo.admin,
                                                            firstName: dtoUserInfo.firstName,
                                                            id: dtoUserInfo.id,
                                                            lastName: dtoUserInfo.lastName,
                                                            middleName: dtoUserInfo.middleName)
                                    return completion(userInfo, nil)
                                }
                            .store(in: &anyCancellable)
                }
            } receiveValue: { tokenData in
                AppSession.tokens = tokenData
            }
            .store(in: &anyCancellable)
    }
    
    func getUserInfo(completion: @escaping (UserInfo?, NetworkError?) -> Void) {
        self.repository?.userInfo()
            .sink { anyCompletion in
                switch anyCompletion {
                case .failure(let error):
                    return completion(nil, error)
                case .finished:
                    break
                }
            }
            receiveValue: { dtoUserInfo in
                let userInfo = UserInfo(admin: dtoUserInfo.admin,
                                        firstName: dtoUserInfo.firstName,
                                        id: dtoUserInfo.id,
                                        lastName: dtoUserInfo.lastName,
                                        middleName: dtoUserInfo.middleName)
                return completion(userInfo, nil)
            }
            .store(in: &anyCancellable)
    }

}
