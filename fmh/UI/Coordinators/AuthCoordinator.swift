//
//  AuthCoordinator.swift
//  fmh
//
//  Created: 23.11.2022
//

import Foundation

protocol AuthCoordinatorProtocol: AnyObject {

}


final class AuthCoordinator: BaseCoordinator {
    
    weak var parentCoordinator: AppCoordinatorProtocol?
    
    private let factory: AuthScreenFactoryProtocol
    
    init(router: Routable, factory: AuthScreenFactoryProtocol) {
        self.factory = factory
        super.init(router: router)
    }
    
    override func start() {
        DispatchQueue.main.async { [weak self] in
            self?.router.setWindowRoot(TestVC())
        }
        
    }
    
}

// MARK: AuthCoordinatorProtocol -
extension AuthCoordinator: AuthCoordinatorProtocol {
    
    
}


import UIKit

class TestVC: BaseViewController {
    
}
