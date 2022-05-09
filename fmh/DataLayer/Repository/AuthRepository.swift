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

class AuthRepository {
    
    private let appUser: AppUser
    private let network: NetworkProtocol
    private let resource: APIResourceAuthProtocol = APIResourceAuth()
    
    init(network: NetworkProtocol, appUser: AppUser) {
        self.network = network
        self.appUser = appUser
    }
    
}

// MARK: - AuthRepositoryProtocol
extension AuthRepository: AuthRepositoryProtocol {

    func login(login: String, password: String) -> AnyPublisher<Bool, APIError> {
        return network
            .fetchDataPublisher(resource: resource.login(login: login, password: password))
            .map({ [unowned self] tokenData in
                self.appUser.login(tokenData: tokenData)
                return true
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func refresh(_ refreshToken: String) -> AnyPublisher<Bool, APIError> {
        return network
            .fetchDataPublisher(resource: resource.refresh(refreshToken))
            .map({ [unowned self] tokenData in
                self.appUser.login(tokenData: tokenData)
                return true
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func userInfo() -> AnyPublisher<UserInfo, APIError> {
        return network
            .fetchDataPublisher(resource: resource.userInfo())
            .map { $0 }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

}
