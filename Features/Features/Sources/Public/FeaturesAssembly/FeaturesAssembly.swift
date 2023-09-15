
import UIKit
import Coordinating

public final class FeaturesAssembly: FeaturesAssemblyProtocol {
    
    // Dependencies
    private let dependencies: FeaturesDependencies
    
    // MARK: - Life cycle
    
    public init(dependencies: FeaturesDependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - FeaturesAssemblyProtocol
    
    // MARK: tabBarControllerCoordinator.
    public lazy var tabBarControllerCoordinator: CoordinatorProtocol = {
        let viewControllersAssembly = TabBarControllersAssembly(dependencies: dependencies)
        return TabBarControllerCoordinator(
            router: self.dependencies.router,
            dependencies: .init(
                onCompletion: nil,
                viewControllers: viewControllersAssembly.viewControllers
            ))
    }()
    
    // MARK: tabBarWithMenuControllerCoordinator.
    public lazy var tabBarWithMenuControllerCoordinator: CoordinatorProtocol = {
        let configurationMenu = SideMenuConfiguration(dependencies: dependencies)
        let viewControllersAssembly = TabBarWithMenuControllersAssembly(dependencies: dependencies)
        return TabBarWithMenuControllerCoordinator(
            router: self.dependencies.router,
            dependencies: .init(
                onCompletion: nil,
                network: dependencies.network,
                viewControllers: viewControllersAssembly.viewControllers,
                sideMenuSectionItems: configurationMenu.sideMenuSectionItems
            ))
    }()
    
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
