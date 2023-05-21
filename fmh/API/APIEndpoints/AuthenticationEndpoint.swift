//
//  AuthenticationEndpoint.swift
//  fmh
//
//  Created: 21.05.2023
//

import Foundation

enum AuthenticationEndpoint {
    
    /// Аутентификация пользователя
    /// - Parameters:
    ///   - login: Имя пользователя
    ///   - password: Пароль пользователя
    /// - Returns: Endpoint
    static func login(login: String, password: String) -> Endpoint<DTOUserInfo> {
        let bodyData = try? ["login": login, "password": password].data()
        return Endpoint(method: .POST, path: "/api/fmh/authentication/login", body: bodyData)
    }
    
    /// Получение текущего авторизованного пользователя
    /// - Returns: Endpoint
    static var userInfo: Endpoint<DTOUserInfo> {
        Endpoint(path: "/api/fmh/authentication/userInfo")
    }
    
    /// Обновление токенов
    /// - Parameter refreshToken: Токен для обновления токенов
    /// - Returns: Endpoint
    static func refresh(refreshToken: String) -> Endpoint<DTOUserInfo> {
        let bodyData = try? ["refreshToken": refreshToken].data()
        return Endpoint(method: .POST, path: "/api/fmh/authentication/refresh", body: bodyData)
    }
}
