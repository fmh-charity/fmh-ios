//
//  AuthCoordinator.swift
//  fmh
//
//  Created: 23.11.2022
//

import Foundation

final class AuthCoordinator: BaseCoordinator {
    
    fileprivate let factory: AuthScreenFactoryProtocol
    fileprivate let router: Routable
    
    init(router: Routable, factory: AuthScreenFactoryProtocol) {
        self.router  = router
        self.factory = factory
    }
    
    override func start() {
        
    }

}

// MARK: - Navigation flows
fileprivate extension AuthCoordinator {

}
