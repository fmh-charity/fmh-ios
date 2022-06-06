//
//  AppCoordinator_.swift
//  fmh
//
//  Created: 14.05.2022
//

///                           AppCoordinator
///                                |
///         ----------------------------------------------
///         |                                                  |                                                  |
/// LoadingViewController            AuthorizationCoordinator                GeneralCoordinator

import UIKit

final class AppCoordinator: CoordinatorProtocol {
    
    var childCoordinators = [CoordinatorProtocol]()
    var onCompletion: (() -> ())?
    
    private let window: UIWindow
    private let moduleFactory = ModuleFactory()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        loadFlow()
    }
    
    /// Select flow after completion loadingCoordinator
    private func selectFlow () {
        switch AppSession.isAuthorized {
            case true:
                generalFlow()
            case false:
                autorizationFlow()
        }
    }
    
}

// MARK: - Navigation flows
extension AppCoordinator {
    
    /// Show loading controllerView
    private func loadFlow() {
        let viewController = moduleFactory.makeLoadingViewController()
        viewController.onCompletion = { [unowned self] in
            self.selectFlow()
        }
        window.rootViewController = viewController.toPresent
    }
    
    /// Show autorization coordinator
    private func autorizationFlow() {
        let navigationController = makeNavigationController()
        let coordinator = AutorozationCoordinatror(navigationController: navigationController, moduleFactory: moduleFactory)

        childAppend(coordinator)
        coordinator.onCompletion = { [unowned self, unowned coordinator] in
            self.childRemove(coordinator)
            self.selectFlow()
        }
        coordinator.start()
        window.rootViewController = navigationController
    }
    
    /// Show general coordinator
    private func generalFlow() {
        let navigationController = makeNavigationController()
        let coordinator = GeneralCoordinator(window: window, moduleFactory: moduleFactory, navigationController: navigationController)

        childAppend(coordinator)
        coordinator.onCompletion = { [unowned self, unowned coordinator] in
            AppSession.logOut() /// <- При завершении GeneralCoordinator всегда разлогиниваемся
            self.childRemove(coordinator)
            self.selectFlow()
        }
        coordinator.start()
    }
    
}

// MARK: - makeNavigationController
extension AppCoordinator {
    
    private func makeNavigationController() -> UINavigationController {
        let navigationController = UINavigationController()
        
        let app = UINavigationBarAppearance()
        app.titleTextAttributes = [.foregroundColor: UIColor.white]
        app.backgroundColor = .accentColor
        navigationController.navigationBar.compactAppearance = app
        navigationController.navigationBar.standardAppearance = app
        navigationController.navigationBar.scrollEdgeAppearance = app
        navigationController.navigationBar.tintColor = .white
        
        return navigationController
    }
    
}
