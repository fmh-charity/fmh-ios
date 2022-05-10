//
//  ModulesFactory.swift
//  fmh
//
//  Created: 09.05.2022
//

import Foundation
import UIKit

final class ModulesFactory {}

// MARK: - AuthorizationFactoryProtocol
extension ModulesFactory: AuthorizationFactoryProtocol {
    func makeAuthorizationView() -> AuthorizationViewProtocol {
        let viewController: AuthorizationViewController = AuthorizationViewController()
        
        let repository: AuthRepositoryProtocol = AuthRepository()
        
        AuthorizationAssembly.assembly(with: viewController, repository: repository)
        return viewController
    }
}

// MARK: - MainFactoryProtocol
extension ModulesFactory: MainFactoryProtocol {
    func makeMainView() -> MainViewProtocol {
        let viewController: MainViewController = MainViewController()
        MainAssembly.assembly(with: viewController)
        return viewController
    }
}


// MARK: - Private methods
private extension ModulesFactory {
    func router(_ navController: UINavigationController?) -> Routable {
        return Router(rootController: navigationController(navController))
    }
    
    func navigationController(_ navController: UINavigationController?) -> UINavigationController {
        return navController == nil ? UINavigationController() : UINavigationController()
    }
    
//    func router(_ navController: UINavigationController?, in storyboard: Storyboards) -> Routable {
//        return Router(rootController: navigationController(navController, in: storyboard))
//    }
//
//    func navigationController(_ navController: UINavigationController?, in storyboard: Storyboards) -> UINavigationController {
//        return navController == nil ? UINavigationController.controllerFromStoryboard(storyboard) : navController!
//    }
}
