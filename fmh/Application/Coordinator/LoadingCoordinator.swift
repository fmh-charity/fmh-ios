//
//  LoadingCoordinator_.swift
//  fmh
//
//  Created: 14.05.2022
//

import Foundation
import UIKit

class LoadingCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController: UINavigationController
     
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController: LoadingViewController = LoadingViewController()
        let presenter  = LoadingPresenter()
        
        presenter.output = viewController
        viewController.presenter = presenter
        viewController.delegate = self
        
        navigationController.viewControllers = [viewController]
        navigationController.isNavigationBarHidden = true
    }
}

// MARK: - LoadingViewControllerDelegate
extension LoadingCoordinator: LoadingViewControllerDelegate {
    func onCompletion() {
        let coordinator = GeneralCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
