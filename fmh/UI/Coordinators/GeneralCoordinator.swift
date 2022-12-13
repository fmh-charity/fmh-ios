//
//  GeneralCoordinator.swift
//  fmh
//
//  Created: 24.11.2022
//

import Foundation

protocol GeneralCoordinatorProtocol: AnyObject {
    
}


final class GeneralCoordinator: BaseCoordinator {
    
    weak var parentCoordinator: AppCoordinatorProtocol?
    
    private let factory: GeneralScreenFactoryProtocol
    
    var apiClient: APIClientProtocol?
    
    init(router: Routable, factory: GeneralScreenFactoryProtocol) {
        self.factory = factory
        super.init(router: router)
    }
    
    override func start() {
        performSideMenuNavigationFlow()
    }
    
}

// MARK: GeneralCoordinatorProtocol -
extension GeneralCoordinator {
    
    enum Flow { case general } // ??? <- Возможно данные передавать еще ...
    
    func performSideMenuNavigationFlow() {
        let naviganionController: SideMenuNavigationControllerProtocol = SideMenuNavigationController(menuViewControllers: [:])
        naviganionController.isNavigationBarHidden = false
        naviganionController.setUserPofile(apiClient?.userProfile)
        naviganionController.onCompletion = onCompletion
        router.setNavigationController(naviganionController)
    }
    
}
