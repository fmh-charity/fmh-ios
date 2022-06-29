//
//  GeneralCoordinator.swift
//  fmh
//
//  Created: 15.05.2022
//

import UIKit

final class GeneralCoordinator: CoordinatorProtocol {
    
    var childCoordinators = [CoordinatorProtocol]()
    var onCompletion: (() -> ())?
    
    private let window: UIWindow
    private let moduleFactory: GeneralModuleFactoryProtocol
    private var navigationController: UINavigationController
     
    init(window: UIWindow, moduleFactory: GeneralModuleFactoryProtocol, navigationController: UINavigationController) {
        self.window = window
        self.moduleFactory = moduleFactory
        self.navigationController = navigationController
    }
    
    func start() {
        generalMenuFlow()
    }

}

// MARK: - Navigation flows
extension GeneralCoordinator {
    
    private func generalMenuFlow() {
        let viewController = moduleFactory.makeGeneralViewController()
        viewController.onCompletion = { [unowned self] in
            self.onCompletion?()
        }
        
        /// Set efault ViewController in GeneralViewController.contextViewController
        let defaultViewController = self.moduleFactory.makeTemplateViewController()
        navigationController.viewControllers = [defaultViewController.toPresent]
        
        viewController.didSelectMenu = { [unowned self] menu in
            switch menu {
                case .home:
                    let viewController = self.moduleFactory.makeTemplateViewController()
                    navigationController.viewControllers = [viewController.toPresent]
                case .ourMission:
                    break
                case .news:
                    let viewController = self.moduleFactory.makeNewsListViewController()
                    navigationController.viewControllers = [viewController.toPresent]
                case .claim:
                    break
                case .patients:
                    break
                case .chambers:
                    break
            }
        }
        
        viewController.didSelectAdditionalMenu = { [unowned self] additionalMenu in
            switch additionalMenu {
                case .user:
                    break
                case .logOut:
                    self.onCompletion?()
            }
        }
        
        /// Set  select ViewController in GeneralViewController.contextViewController
        viewController.contextViewController = navigationController
        window.rootViewController = viewController.toPresent
    }

}

