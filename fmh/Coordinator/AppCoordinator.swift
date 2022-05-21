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
    
    fileprivate unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
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
        
        navigationController.viewControllers = [viewController]
        navigationController.isNavigationBarHidden = true
    }
    
    /// Show autorization coordinator
    func autorizationFlow() {
        let coordinator = AutorozationCoordinatror(navigationController: navigationController)
        
        childAppend(coordinator)
        coordinator.start()
        
        coordinator.isCompletion = { [unowned self, unowned coordinator] in
            self.childRemove(coordinator)
            self.selectFlow()
        }
    }
    /// Show general coordinator
    func generalFlow() {
        let coordinator = GeneralCoordinator(navigationController: navigationController)
        
        childAppend(coordinator)
        coordinator.start()
        
        coordinator.isCompletion = { [unowned self, unowned coordinator] in
            self.childRemove(coordinator)
            self.selectFlow()
        }
    }
    
}
