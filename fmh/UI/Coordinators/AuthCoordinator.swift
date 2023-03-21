//
//  AuthCoordinator.swift
//  fmh
//
//  Created: 23.11.2022
//

import Foundation

protocol AuthCoordinatorProtocol: AnyObject {
    func performLoginScreenFlow()
    func performRegistrationScreenFlow()
    func performForgotPasswordScreenFlow()
}

// MARK: - AuthCoordinator

final class AuthCoordinator: Coordinator {
    
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

// MARK: - AuthCoordinatorProtocol

extension AuthCoordinator: AuthCoordinatorProtocol {
    
    func performLoginScreenFlow() {
        let viewController = factory.makeLoginViewController()
        viewController.onCompletion = onCompletion
        viewController.coordinator = self
        router.setDefaultNavigationController()
        router.setRoot(viewController, hideBar: false)
    }
    
    func performRegistrationScreenFlow() {
        let viewController = factory.makeRegistrationViewController()
        viewController.onCompletion = onCompletion
        router.push(viewController, animated: true)
    }
    
    func performForgotPasswordScreenFlow() {
        let viewController = factory.makeForgotPasswordViewController()
        viewController.onCompletion = onCompletion
        router.push(viewController, animated: true)
    }
}
