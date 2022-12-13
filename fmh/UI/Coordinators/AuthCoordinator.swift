//
//  AuthCoordinator.swift
//  fmh
//
//  Created: 23.11.2022
//

import Foundation

protocol AuthCoordinatorProtocol: AnyObject {
    func performLoginScreenFlow()
}


final class AuthCoordinator: BaseCoordinator {
    
    weak var parentCoordinator: AppCoordinatorProtocol?
    
    private let factory: AuthScreenFactoryProtocol
    
    init(router: Routable, factory: AuthScreenFactoryProtocol) {
        self.factory = factory
        super.init(router: router)
    }
    
    override func start() {
        performLoginScreenFlow()
    }
    
}

// MARK: AuthCoordinatorProtocol -
extension AuthCoordinator: AuthCoordinatorProtocol {
    
    func performLoginScreenFlow() {
        let viewController = factory.makeLoginViewController()
        viewController.onCompletion = onCompletion
        router.setRoot(viewController, hideBar: false)
    }
    
}

