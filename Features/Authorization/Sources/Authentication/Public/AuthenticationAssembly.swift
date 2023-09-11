
import UIKit

public final class AuthenticationAssembly {
    
    private let dependencies: AuthenticationDependencies
    
    public init(dependencies: AuthenticationDependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: Private
    
    private lazy var networkService: NetworkServiceProtocol = {
        NetworkService(network: dependencies.network)
    }()
}

// MARK: - AuthenticationAssemblyProtocol

extension AuthenticationAssembly: AuthenticationAssemblyProtocol {
    
    public var authenticationViewController: UIViewController {
        let authenticationService = AuthenticationService(
            networkService: networkService,
            tokenProvider: dependencies.tokenProvider
        )
        let presenter = AuthenticationPresenter(
            onCompletion: dependencies.onCompletion,
            authenticationService: authenticationService
        )
        let viewController = AuthenticationViewController(presenter: presenter)
        return viewController
    }
}
