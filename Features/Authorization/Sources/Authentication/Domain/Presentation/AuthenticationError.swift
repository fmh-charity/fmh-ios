
import Foundation

enum AuthenticationError: Error {
    case requestError(Error)
    case loginError(String)
    case passwordError(String)
}

extension AuthenticationError {
    
}
