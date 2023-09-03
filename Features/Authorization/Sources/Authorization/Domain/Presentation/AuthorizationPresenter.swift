
import Foundation

protocol AuthorizationPresenterProtocol {
    
}

protocol AuthorizationPresenterDelegate: AnyObject {
    
}

// MARK: - AuthorizationPresenter

final class AuthorizationPresenter {
    
    // Dependences
    weak var delegate: AuthorizationPresenterDelegate?
    
    // MARK: Life cycle
    init() {
        
    }
}

// MARK: - AuthorizationPresenterProtocol

extension AuthorizationPresenter: AuthorizationPresenterProtocol {

}
