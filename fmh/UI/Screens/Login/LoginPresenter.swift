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


// MARK: - LoginPresenterProtocol
extension LoginPresenter: LoginPresenterProtocol {
    
    func login(login: String, password: String, completion: @escaping (Bool, String?) -> Void ) {
        
        Task(priority: .background) {
            do {
                try await apiClient.login(login: login, password: password)
                DispatchQueue.main.async {
                    return completion(true, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    return completion(false, error.localizedDescription)
                }
            }
        }
    }
}
