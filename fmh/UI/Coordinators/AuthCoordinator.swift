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
    
    private var apiClient: APIClientProtocol
    
    init(router: Routable, factory: AuthScreenFactoryProtocol, apiClient: APIClientProtocol) {
        self.router  = router
        self.factory = factory
        self.apiClient = apiClient
    }
    
    override func start() {
        
    }
    
}

// MARK: - Navigation flows
fileprivate extension AuthCoordinator {
    
    enum Flow { case login } // <- Возможно данные передавать еще ...
    
    func performLoginScreenFlow() {
        let viewController = TempVC()
        viewController.onCompletion = onCompletion
        /*
        viewController.needExecute = { [weak self] params in
            if let flow = params["flow"] as? Flow {
                switch flow {
                default: break
                }
            }
        }
         */
        router.setWindowRoot(viewController)
    }
    
    // ...
    
}


import UIKit
class TempVC: BaseViewController { }
