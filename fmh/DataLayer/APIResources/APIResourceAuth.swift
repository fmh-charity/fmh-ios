//
//  APIResourceAuthentication.swift
//  fmh
//
//  Created: 29.04.2022
//

import Foundation

// TODO: Перевести какнить в Enum

protocol APIResourceAuthProtocol {
    
    func login(login: String, password: String) -> APIResource<TokenData>
    func refresh(_ refreshToken: String) -> APIResource<TokenData>
    func userInfo() -> APIResource<UserInfo>
    
}


struct APIResourceAuth: APIResourceAuthProtocol {
    
    func login(login: String, password: String) -> APIResource<TokenData> {
        APIResource(path: "authentication/login",
                    method: .post,
                    body: Credentials(login: login, password: password))
    }
    
    func refresh(_ refreshToken: String) -> APIResource<TokenData> {
        APIResource(path: "authentication/refresh",
                    method: .post,
                    body: RefreshToken(refreshToken: refreshToken))
    }
    
    func userInfo() -> APIResource<UserInfo> {
        APIResource(path: "authentication/userInfo",
                    method: .get)
    }
    
}

