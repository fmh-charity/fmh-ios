//
//  AuthRepository.swift
//  fmh
//
//  Created: 07.05.2022
//

import Foundation
import Combine

protocol AuthRepositoryProtocol {
    
    func login(login: String, password: String) -> AnyPublisher<TokenData, APIError>
    func refresh(_ refreshToken: String) -> AnyPublisher<TokenData, APIError>
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
    
    func login(login: String, password: String) -> AnyPublisher<TokenData, APIError> {
        return fetchDataPublisher(resource: resource.login(login: login, password: password))
            .map { $0 }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func refresh(_ refreshToken: String) -> AnyPublisher<TokenData, APIError> {
        return fetchDataPublisher(resource: resource.refresh(refreshToken))
            .map { $0 }
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
