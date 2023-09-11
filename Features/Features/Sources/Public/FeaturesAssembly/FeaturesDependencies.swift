
import Foundation
import Coordinating
import Networking
import Authorization

// MARK: Зависимости для всех модулей

public struct FeaturesDependencies {

    public let router: RouterProtocol
    public let network: NetworkProtocol
    public let tokenProvider: TokenProviderProtocol
    
    public init(
        router: RouterProtocol,
        network: NetworkProtocol,
        tokenProvider: TokenProviderProtocol
    ) {
        self.router = router
        self.network = network
        self.tokenProvider = tokenProvider
    }
}
