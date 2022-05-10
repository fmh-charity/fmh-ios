//
//  AuthorizationError.swift
//  fmh
//
//  Created: 03.05.2022
//

import Foundation

enum AuthorizationError: Error {
    
    case loginFieldEmpty
    case passwordFieldEmpty
    case loginPasswordFieldEmpty
    case loginPasswordInvalid
    
    case unauthorized
    case requestError (APIError)
    case requestTimedOut
    case notConnectToServer
    case forbidden
}

extension AuthorizationError: LocalizedError {
    // TODO: Добавить расшифровку ошибок на русском. (AuthError) Возможно перенести в APIError
    public var errorDescription: String? {
        switch self {
        case .loginFieldEmpty:
            return NSLocalizedString("Поле логин не должно быть пустым.", comment: "loginFieldEmpty")
        case .passwordFieldEmpty:
            return NSLocalizedString("Поле пароль не должно быть пустым.", comment: "passwordFieldEmpty")
        case .loginPasswordFieldEmpty:
            return NSLocalizedString("Поля логин и пароль не должны быть пустыми.", comment: "loginPasswordFieldEmpty")
        case .loginPasswordInvalid:
            return NSLocalizedString("Не верно указан логин или пароль.", comment: "loginPasswordInvalid")
            
        case .unauthorized:
            return NSLocalizedString("Не действительные учетные данные.", comment: "unauthorized")
        case .requestError(let error):
            return NSLocalizedString(error.localizedDescription, comment: "requestError")
        case .requestTimedOut:
            return NSLocalizedString("Время запроса истекло.", comment: "requestTimedOut")
        case .notConnectToServer:
            return NSLocalizedString("Не удалось установить соединение с сервером.", comment: "notConnectToServer")
        case .forbidden:
            return NSLocalizedString("Запрещенно.", comment: "forbidden")
        }
    }
    
}
