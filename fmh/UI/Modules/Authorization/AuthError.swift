//
//  AuthError.swift
//  fmh
//
//  Created: 03.05.2022
//

import Foundation

enum AuthError: Error {
    
    case loginFieldEmpty
    case passwordFieldEmpty
    case loginPasswordFieldEmpty
    case loginPasswordInvalid
    
    case unauthorized
    case requestError (Error)
    case requestTimedOut
    case forbidden
}

extension AuthError: LocalizedError {
    // TODO: Добавить расшифровку ошибок на русском. (AuthError)
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
        case .forbidden:
            return NSLocalizedString("Запрещенно.", comment: "forbidden")
        }
    }
    
}
