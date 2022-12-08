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
