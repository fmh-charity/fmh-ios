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

import Foundation
import UIKit

final class AppCoordinator: BaseCoordinator {
    
    private let window: UIWindow
    private let rootNavigationController: UINavigationController
    
    init(navigationController: UINavigationController, window: UIWindow) {
        self.rootNavigationController = navigationController
        self.window = window
    }
    
    override func start() {
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
    func loadFlow() {
        let viewController: LoadingViewController = LoadingViewController()
        let presenter  = LoadingPresenter(output: viewController)
        
        viewController.presenter = presenter
        
        presenter.isCompletion = { [unowned self] in
            self.selectFlow()
        }
        
        window.rootViewController = viewController
    }
    
    /// Show autorization coordinator
    func autorizationFlow() {
        let coordinator = AutorozationCoordinatror(navigationController: rootNavigationController)

        childAppend(coordinator)
        coordinator.start()

        coordinator.isCompletion = { [unowned self, unowned coordinator] in
            self.childRemove(coordinator)
            self.selectFlow()
        }
        
        window.rootViewController = rootNavigationController
    }
    /// Show general coordinator
    func generalFlow() {
        let coordinator = GeneralCoordinator(window: window, navigationController: rootNavigationController)

        childAppend(coordinator)
        coordinator.start()

        coordinator.isCompletion = { [unowned self, unowned coordinator] in
            self.childRemove(coordinator)
            self.selectFlow()
        }
    }
    
}
