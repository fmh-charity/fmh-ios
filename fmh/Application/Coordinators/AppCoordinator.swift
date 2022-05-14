//
//  AppCoordinator.swift
//  fmh
//
//  Created: 10.05.2022
//

import Foundation

final class AppCoordinator: Coordinator {
    
    fileprivate let factory: CoordinatorFactoryProtocol
    fileprivate let router : Routable
    
    fileprivate var isAutorization: Bool {
        AppSession.isAuthorized ? true : false
    }
    
    init(router: Routable, factory: CoordinatorFactory) {
        self.router  = router
        self.factory = factory
    }
    
}

// MARK:- Coordinatable
extension AppCoordinator: Coordinatable {
    
    func start() {
        performLoadingFlow()
    }
    
}

// MARK:- Private methods
private extension AppCoordinator {
    
    func selectFlow() {
        switch isAutorization {
            case true: performMainFlow()
            case false: performAuthorizationFlow()
        }
    }
    
    func performLoadingFlow() {
        let coordinator = factory.makeLoadingCoordinator(router: router)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.removeDependency(coordinator)
            self.selectFlow()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    func performAuthorizationFlow() {
        let coordinator = factory.makeAuthorizationCoordinator(router: router)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.removeDependency(coordinator)
            self.selectFlow()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    func performMainFlow() {
        let coordinator = factory.makeMainCoordinator(router: router)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.selectFlow()
            self.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    
}
