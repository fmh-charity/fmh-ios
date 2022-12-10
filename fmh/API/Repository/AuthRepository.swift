//
//  AuthRepository.swift
//  fmh
//
//  Created: 09.12.2022
//

import Foundation

protocol AuthRepositoryProtocol {
    var userProfile: APIClient.UserProfile? { get }
    
    func login(login: String, password: String, onComplition: ((Error?) -> Void)?)
    func logout()
}


final class AuthRepository {
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient.shared) { // <- ?
        self.apiClient = apiClient
    }
    
}


//MARK: - AuthRepositoryProtocol
extension AuthRepository: AuthRepositoryProtocol {
    
    var userProfile: APIClient.UserProfile? {
        apiClient.userProfile
    }
    
    func login(login: String, password: String, onComplition: ((Error?) -> Void)?) {
        apiClient.login(login: login, password: password, onComplition: onComplition)
    }

    func logout() {
        apiClient.logout()
    }
    
}
