
import Foundation
import Networking

public struct AuthenticationDependencies {

    public var onCompletion: (() -> Void)?
    public let network: NetworkProtocol
    public let tokenProvider: TokenProviderProtocol
    
    public init(
        onCompletion: (() -> Void)?,
        network: NetworkProtocol,
        tokenProvider: TokenProviderProtocol
    ) {
        self.onCompletion = onCompletion
        self.network = network
        self.tokenProvider = tokenProvider
    }
}
