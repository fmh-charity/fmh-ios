//
//  AuthorizationCoordinator.swift
//  fmh
//
//  Created: 10.05.2022
//

import Foundation

protocol AuthorizationCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
}

final class AuthorizationCoordinator: Coordinator, AuthorizationCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    fileprivate let factory: AuthorizationModuleFactoryProtocol
    fileprivate let router : Routable
    
    init(with factory: AuthorizationModuleFactoryProtocol, router: Routable) {
        self.factory = factory
        self.router  = router
    }
}

// MARK: - Coordinatable
extension AuthorizationCoordinator: Coordinatable {
    func start() {
        performFlow()
    }
}

// MARK: - Private methods
private extension AuthorizationCoordinator {
    func performFlow() {
        let view = factory.makeAuthorizationView()
        view.onCompletion = finishFlow
        
        router.setRootModule(view, hideBar: false)
    }
}
