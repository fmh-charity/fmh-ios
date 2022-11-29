//
//  AppCoordinator.swift
//  fmh
//
//  Created: 23.11.2022
//

import Foundation

final class AppCoordinator: BaseCoordinator {
    
    fileprivate let factory: ScreenFactory
    fileprivate let router: Routable
    
//    var apiClient: 
    
    init(router: Routable, factory: ScreenFactory) {
        self.router  = router
        self.factory = factory
    }
    
    override func start() {
        performLoadingFlow()
    }

}

// MARK:- Private methods
private extension AppCoordinator {
    
    private func selectFlow() {
        
    }
    
    func performLoadingFlow() {
        let coordinator = LoadingCoordinator(router: router, factory: factory)
        coordinator.onCompletion = { [weak self, weak coordinator] in
            self?.childRemove(coordinator)
            self?.selectFlow()
        }
        childAppend(coordinator)
        coordinator.start()
    }
    
    func performAuthFlow() {
        let coordinator = AuthCoordinator(router: router, factory: factory)
        coordinator.onCompletion = { [weak self, weak coordinator] in
            self?.childRemove(coordinator)
            self?.selectFlow()
        }
        childAppend(coordinator)
        coordinator.start()
    }
    
    func performGeneralFlow() {
        let coordinator = GeneralCoordinator(router: router, factory: factory)
        coordinator.onCompletion = { [weak self, weak coordinator] in
            self?.childRemove(coordinator)
            self?.selectFlow()
        }
        childAppend(coordinator)
        coordinator.start()
    }
    
}
