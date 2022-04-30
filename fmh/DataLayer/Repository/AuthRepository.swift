//
//  AuthenticationRepository.swift
//  fmh
//
//  Created: 29.04.2022
//

import Foundation

protocol AuthRepositoryProtocol {
    
    func login (login: String, password: String, completion: @escaping (Result<TokenData, APIError>) -> Void)
    func refresh (_ refreshToken: String, completion: @escaping (Result<TokenData, APIError>) -> Void)
    func userInfo (completion: @escaping (Result<UserInfo, APIError>) -> Void)

}


class AuthRepository: NetworkService {
    
    private let resource: APIResourceAuthProtocol
    
    init(resource: APIResourceAuthProtocol = APIResourceAuth()) {
        self.resource = resource
    }
    
}


// MARK: - AuthRepositoryProtocol
extension AuthRepository: AuthRepositoryProtocol {
 
    func login(login: String, password: String, completion: @escaping (Result<TokenData, APIError>) -> Void) {
        getResurce(with: resource.login(login: login, password: password)) { result in
            switch result {
            case .success(let tokenData):
                completion(.success(tokenData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func refresh(_ refreshToken: String, completion: @escaping (Result<TokenData, APIError>) -> Void) {
        getResurce(with: resource.refresh(refreshToken)) { result in
            switch result {
            case .success(let tokenData):
                completion(.success(tokenData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func userInfo(completion: @escaping (Result<UserInfo, APIError>) -> Void) {
        getResurce(with: resource.userInfo()) { result in
            switch result {
            case .success(let userInfo):
                completion(.success(userInfo))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }


}
