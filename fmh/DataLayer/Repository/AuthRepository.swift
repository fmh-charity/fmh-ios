//
//  AuthRepository.swift
//  fmh
//
//  Created: 07.05.2022
//

import Foundation
import Combine

protocol AuthRepositoryProtocol {
    
    func login(login: String, password: String) -> AnyPublisher<DTOTokenData, NetworkError>
    func refresh(_ refreshToken: String) -> AnyPublisher<DTOTokenData, NetworkError>
    func userInfo() -> AnyPublisher<DTOUserInfo, NetworkError>
    
}

class AuthRepository: Network {
    
    override init() {
        super.init()
    }
    
}

// MARK: - AuthRepositoryProtocol
extension AuthRepository: AuthRepositoryProtocol {
    
    func login(login: String, password: String) -> AnyPublisher<DTOTokenData, NetworkError> {
        let resource = APIResourceAuth.login(login: login, password: password)
        return fetchDataPublisher(resource: resource.resource())
            .map { $0 }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func refresh(_ refreshToken: String) -> AnyPublisher<DTOTokenData, NetworkError> {
        let resource = APIResourceAuth.refresh(refreshToken: refreshToken)
        return fetchDataPublisher(resource: resource.resource())
            .map { $0 }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func userInfo() -> AnyPublisher<DTOUserInfo, NetworkError> {
        let resource = APIResourceAuth.userInfo
        return fetchDataPublisher(resource: resource.resource())
            .map { $0 }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
