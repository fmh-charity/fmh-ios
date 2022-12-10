//
//  GeneralCoordinator.swift
//  fmh
//
//  Created: 24.11.2022
//

import Foundation

final class GeneralCoordinator: BaseCoordinator {
    
    fileprivate let factory: GeneralScreenFactoryProtocol
    fileprivate let router: Routable
    
    private var apiClient: APIClientProtocol
    
    init(router: Routable, factory: GeneralScreenFactoryProtocol, apiClient: APIClientProtocol) {
        self.router  = router
        self.factory = factory
        self.apiClient = apiClient
    }
    
    override func start() {
        
    }
    
}

// MARK: - Navigation flows
fileprivate extension GeneralCoordinator {
    
    enum Flow { case general } // <- Возможно данные передавать еще ...
    
}
