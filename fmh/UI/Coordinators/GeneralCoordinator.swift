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
    
    init(router: Routable, factory: GeneralScreenFactoryProtocol) {
        self.router  = router
        self.factory = factory
    }
    
    override func start() {
        
    }

}

// MARK: - Navigation flows
fileprivate extension GeneralCoordinator {
//onComplitionViewController: ((_ params: String) -> ())?
}
