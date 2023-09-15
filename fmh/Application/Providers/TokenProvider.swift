
import Foundation
import Authorization

final class TokenProvider: TokenProviderProtocol {
    
    func updateTokens(accessToken: String?, refreshToken: String?) {
        //TODO: Написать класс который будет отвечать за хранение токенов в keyChain!
        UserDefaults.standard.set(accessToken, forKey: "accessToken")
        UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
    }
}
