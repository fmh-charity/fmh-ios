
import Foundation
import Networking

protocol AuthenticationPresenterProtocol {
    func login(login: String, password: String, completion: @escaping (AuthenticationError) -> Void)
}

// MARK: - AuthenticationPresenter

final class AuthenticationPresenter {
    
    // Dependences
    private var onCompletion: (() -> Void)?
    private let authenticationService: AuthenticationServiceProtocol
    
    // MARK: Life cycle
    
    init(
        onCompletion: (() -> Void)?,
        authenticationService: AuthenticationServiceProtocol
    ) {
        self.onCompletion = onCompletion
        self.authenticationService = authenticationService
    }
}

// MARK: - AuthenticationPresenterProtocol

extension AuthenticationPresenter: AuthenticationPresenterProtocol {
    
    func login(login: String, password: String, completion: @escaping (AuthenticationError) -> Void) {
        
        if login.isEmpty {
            completion(AuthenticationError.loginError("Поле не может быть пустым."))
        }
        
        if password.isEmpty {
            completion(AuthenticationError.passwordError("Поле не может быть пустым."))
        }
        
        guard !login.isEmpty, !password.isEmpty else { return }
        authenticationService.login(login: login, password: password) { [weak self] error in
            if let error {
                completion(.requestError(error))
            } else {
                self?.onCompletion?()
            }
        }
    }
}
