//
//  CoordinatorFactory.swift
//  fmh
//
//  Created: 09.05.2022
//

import UIKit

final class CoordinatorFactory {
    fileprivate let modulesFactory = ModulesFactory()
}

// MARK: - CoordinatorFactoryProtocol
extension CoordinatorFactory: CoordinatorFactoryProtocol {

    func makeAuthorizationCoordinator(router: Routable) -> AuthorizationCoordinatorOutput & Coordinatable {
        return AuthorizationCoordinator(with: modulesFactory, router: router)
    }
    
    func makeMainCoordinator(router: Routable) -> Coordinatable & MainCoordinatorOutput {
        return MainCoordinator(with: modulesFactory, router: router)
    }
    
}


// MARK: - Private methods
private extension CoordinatorFactory {
//    func router(_ navController: UINavigationController?, in storyboard: Storyboards) -> Routable {
//        return Router(rootController: navigationController(navController, in: storyboard))
//    }
//
//    func navigationController(_ navController: UINavigationController?, in storyboard: Storyboards) -> UINavigationController {
//        return navController == nil ? UINavigationController.controllerFromStoryboard(storyboard) : navController!
//    }
}
