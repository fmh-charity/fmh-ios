//
//  AutorozationCoordinatror.swift
//  fmh
//
//  Created: 20.05.2022
//

///                       AutorozationCoordinatror
///                                |
///         ----------------------------------------------
///         |                                                  |                                                  |
///  LoginViewController                                  ?                                                 ?

import Foundation
import UIKit

final class AutorozationCoordinatror: BaseCoordinator {
    
    private let navigationController: UINavigationController
    private let moduleFactory: AutorizationModuleFactoryProtocol
    
    init(navigationController: UINavigationController, moduleFactory: AutorizationModuleFactoryProtocol) {
        self.navigationController = navigationController
        self.moduleFactory = moduleFactory
        super.init()
    }
    
    override func start() {
        loginFlow()
    }
    
}

// MARK: - Navigation flows
extension AutorozationCoordinatror {
    
    func loginFlow() {
        let viewController = moduleFactory.makeAuthorizationViewController()
        viewController.onCompletion = { [unowned self] in
            self.onCompletion?()
        }
        
        navigationController.setViewControllers([viewController], animated: false)
        navigationController.isNavigationBarHidden = false
    }
    
}
