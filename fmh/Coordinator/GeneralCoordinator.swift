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
    private let moduleFactory: GeneralModuleFactoryProtocol
    private var navigationController: UINavigationController
     
    init(window: UIWindow, moduleFactory: GeneralModuleFactoryProtocol, navigationController: UINavigationController) {
        self.window = window
        self.moduleFactory = moduleFactory
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
        let viewController = moduleFactory.makeGeneralViewController()

        // TODO: Организавоть обработку меню и перекидывать viewControllers в self.navigationController
        /// Default viewController
        let defaultViewController = makeTemplateViewController()
        navigationController.viewControllers = [defaultViewController]
        viewController.contextViewController = navigationController
        viewController.onCompletion = { [unowned self] in
            self.onCompletion?()
        }
        
        window.rootViewController = viewController
    }
    
    func makeTemplateViewController() -> UIViewController {
        let viewController = moduleFactory.makeTemplateViewController()
        
        return viewController
    }
    
}

