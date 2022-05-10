//
//  AppCoordinator.swift
//  fmh
//
//  Created: 10.05.2022
//

import Foundation

fileprivate enum LaunchInstructor {
    
    case authorization, main
        
    static func setup() -> LaunchInstructor {
        switch (AppSession.isAuthorized) {
        case false:
            return .authorization
        case true:
            return .main
        }
    }
    
}


final class AppCoordinator: Coordinator {
    
    fileprivate let factory: CoordinatorFactoryProtocol
    fileprivate let router : Routable
    
    fileprivate var instructor: LaunchInstructor {
        return LaunchInstructor.setup()
    }
    
    init(router: Routable, factory: CoordinatorFactory) {
        self.router  = router
        self.factory = factory
    }
    
}

// MARK:- Coordinatable
extension AppCoordinator: Coordinatable {
    func start() {
        switch instructor {
        case .authorization:
            performAuthorizationFlow()
        case .main:
            performMainFlow()
        }
    }
}

// MARK:- Private methods
private extension AppCoordinator {
    func performAuthorizationFlow() {
        let coordinator = factory.makeAuthorizationCoordinator(router: router)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.removeDependency(coordinator)
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    func performMainFlow() {
        let coordinator = factory.makeMainCoordinator(router: router)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.start()
            self.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    
}
