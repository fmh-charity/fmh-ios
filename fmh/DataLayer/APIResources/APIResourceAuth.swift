//
//  APIResourceAuthentication.swift
//  fmh
//
//  Created: 29.04.2022
//

import Foundation

enum APIResourceAuth {
    
    case login(login: String, password: String)
    case refresh(refreshToken: String)
    case userInfo

    func resource<T: Decodable>() -> APIResource<T> {
        switch self {
            case .login(let login, let password):
                return APIResource(path: "authentication/login",
                            method: .post,
                            body: Credentials(login: login, password: password))
            case .refresh(let refreshToken):
                return APIResource(path: "authentication/refresh",
                            method: .post,
                            body: RefreshToken(refreshToken: refreshToken))
            case .userInfo:
                return APIResource(path: "authentication/userInfo",
                            method: .get)
        }
    }
}
