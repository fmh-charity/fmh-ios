//
//  GeneralCoordinator.swift
//  fmh
//
//  Created: 15.05.2022
//

import Foundation
import UIKit

final class GeneralCoordinator: BaseCoordinator {
    
    private let window: UIWindow
    private var navigationController: UINavigationController
     
    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
        super.init()
    }
    
    override func start() {
        generalMenuFlow()
    }

}

// MARK: - Navigation flows
extension GeneralCoordinator {
    
    func generalMenuFlow() {
        let repository: AuthRepositoryProtocol = AuthRepository()
        let interactor: AuthInteractorProtocol = AuthInteractor(repository: repository)
        let viewController = GeneralViewController()
        let presenter = GeneralPresenter(output: viewController)
        
        presenter.interactor = interactor
        viewController.presenter = presenter
        
        navigationController.viewControllers = [TemplateViewController()]
        
        viewController.contextViewController = navigationController
        
        presenter.isCompletion = { [unowned self] in
            self.isCompletion?()
        }
        
        window.rootViewController = viewController
    }
    
    func makeTemplateViewController() -> UIViewController {
        let viewController = TemplateViewController()
        
        return viewController
    }
    
}

