//
//  GeneralCoordinator.swift
//  fmh
//
//  Created: 15.05.2022
//

import Foundation
import UIKit

class GeneralCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController: UINavigationController
     
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if AppSession.isAuthorized {
            generalFlow()
        } else {
            autorizationFlow()
        }
    }
}

// MARK: -
extension GeneralCoordinator {
    func autorizationFlow() {
        let repository: AuthRepositoryProtocol = AuthRepository()
        let interactor: AuthInteractorProtocol = AuthInteractor(repository: repository)
        let presenter  = AuthorizationPresenter(interactor: interactor)
        let viewController = AuthorizationViewController()
        
        presenter.output = viewController
        viewController.presenter = presenter
        viewController.delegate = self
        
        navigationController.viewControllers = [viewController]
        //navigationController.setViewControllers([viewController], animated: false)
        navigationController.isNavigationBarHidden = false
    }
    
    func generalFlow() {
        let viewController: GeneralViewController = GeneralViewController()
        let moduleFactory = ModuleFactory()
        let presenter  = GeneralPresenter()
        
        presenter.output = viewController
        viewController.presenter = presenter
        viewController.moduleFactory = moduleFactory
        viewController.delegate = self
        
        navigationController.viewControllers = [viewController]
        //navigationController.setViewControllers([viewController], animated: false)
        navigationController.isNavigationBarHidden = false
    }
}

// MARK: - AuthorizationViewControllerDelegate
extension GeneralCoordinator: AuthorizationViewControllerDelegate {
    func signInOk() {
        generalFlow()
    }
}

// MARK: - LoadingViewControllerDelegate
extension GeneralCoordinator: LoadingViewControllerDelegate {
    func onCompletion() {

    }
}

// MARK: - AuthorizationViewControllerDelegate
extension GeneralCoordinator: GeneralViewControllerDelegate {
    func logOut() {
        autorizationFlow()
    }
}
