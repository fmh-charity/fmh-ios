
import Foundation
import Coordinating

public final class FeaturesAssembly: FeaturesAssemblyProtocol {
    
    // Dependencies
    private let dependencies: FeaturesDependencies
    
    // MARK: - Life cycle
    
    public init(dependencies: FeaturesDependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - FeaturesAssemblyProtocol
    
    // MARK: Загрузочная страница.
    public lazy var loadingCoordinator: CoordinatorProtocol = {
        LoadingCoordinator(
            router: self.dependencies.router,
            dependencies: .init()
        )
    }()
    
    // MARK: Страница Аутентификация пользователя.
    public lazy var authorizationCoordinator: CoordinatorProtocol = {
        AuthorizationCoordinator(
            router: self.dependencies.router,
            dependencies: .init(
                onCompletion: nil,
                network: dependencies.network,
                tokenProvider: dependencies.tokenProvider
            )
        )
    }()
}
