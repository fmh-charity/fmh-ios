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
    
    fileprivate unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    override func start() {
        loginFlow()
    }
    
}

// MARK: - Navigation flows
extension AutorozationCoordinatror {
    
    func loginFlow() {
        let repository: AuthRepositoryProtocol = AuthRepository()
        let interactor: AuthInteractorProtocol = AuthInteractor(repository: repository)
        let viewController = AuthorizationViewController()
        let presenter  = AuthorizationPresenter(output: viewController)
        
        presenter.interactor = interactor
        viewController.presenter = presenter
        
        presenter.isCompletion = { [unowned self] in
            self.isCompletion?()
        }
        
        navigationController.setViewControllers([viewController], animated: false)
        navigationController.isNavigationBarHidden = false
    }
    
}
