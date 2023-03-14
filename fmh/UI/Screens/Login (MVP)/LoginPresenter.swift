//
//  LoginPresenter.swift
//  fmh
//
//  Created: 11.12.2022
//

import Foundation

protocol LoginPresenterProtocol {
    func login(login: String, password: String, completion: @escaping (Bool, String?) -> Void )
}

protocol LoginPresenterDelegate: AnyObject {
    
}


final class LoginPresenter {
    
    weak private var view: LoginPresenterDelegate?
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol, with view: LoginPresenterDelegate) {
        self.apiClient = apiClient
        self.view = view
    }
}


//MARK: - LoginPresenterProtocol
extension LoginPresenter: LoginPresenterProtocol {
    
    func login(login: String, password: String, completion: @escaping (Bool, String?) -> Void ) {
        
        apiClient.login(login: login, password: password) { error in
            DispatchQueue.main.async {
                if error == nil {
                    return completion(true, nil)
                }
                
                if let error = error as? NSError {
                    switch error.code {
                    case 401 :
                        return completion(false, "Не действительные учетные данные.")
                    case 403 :
                        return completion(false, "Запрещенный запрос.")
                    case -1001 :
                        return completion(false, "Время запроса истекло.")
                    case -1004 :
                        return completion(false, "Не удалось установить соединение с сервером.")
                    default:
                        return completion(false, "Не удалось установить соединение с сервером.")
                    }
                }
            }
        }
    }
}
