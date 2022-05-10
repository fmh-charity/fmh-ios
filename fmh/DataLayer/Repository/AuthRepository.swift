//
//  AuthRepository.swift
//  fmh
//
//  Created: 07.05.2022
//

import Foundation
import Combine

protocol AuthRepositoryProtocol {
    
    func login(login: String, password: String) -> AnyPublisher<Bool, APIError>
    func refresh(_ refreshToken: String) -> AnyPublisher<Bool, APIError>
    func userInfo() -> AnyPublisher<UserInfo, APIError>
    
}

class AuthRepository: Network {
    
    private let resource: APIResourceAuthProtocol = APIResourceAuth()
    
    override init() {
        super.init()
    }
    
}

// MARK: - AuthRepositoryProtocol
extension AuthRepository: AuthRepositoryProtocol {
    
    func login(login: String, password: String) -> AnyPublisher<Bool, APIError> {
        return fetchDataPublisher(resource: resource.login(login: login, password: password))
            .map({ tokenData in
                AppSession.tokens = tokenData
                return true
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func refresh(_ refreshToken: String) -> AnyPublisher<Bool, APIError> {
        return fetchDataPublisher(resource: resource.refresh(refreshToken))
            .map({ tokenData in
                AppSession.tokens = tokenData
                return true
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func userInfo() -> AnyPublisher<UserInfo, APIError> {
        return fetchDataPublisher(resource: resource.userInfo())
            .map { $0 }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
