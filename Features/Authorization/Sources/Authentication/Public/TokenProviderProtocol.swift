
import Foundation

public protocol TokenProviderProtocol {
    func updateTokens(accessToken: String?, refreshToken: String?)
}
