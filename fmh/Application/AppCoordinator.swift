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
    
    private lazy var apiClient: APIClientProtocol = {
        let apiClient =  APIClient.shared // <- Наверное надо создать класс ...
        apiClient.urlSession.configuration.urlCache = URLCache.shared
        return apiClient
    }()
    
    init(router: Routable, factory: ScreenFactory) {
        self.router  = router
        self.factory = factory
    }
    
    override func start() {
        performLoadingFlow()
        setInterruption()
    }
    
    // В случае ошибки какой в API - перекидываем на ввод логина
    private func setInterruption() {
        apiClient.didCaseInterruption = { [weak self] _ in
            self?.childCoordinators = []
            self?.performAuthFlow()
        }
    }
    
    private func selectFlow() {
        
//        performLoadingFlow()
//        performAuthFlow()
//        performGeneralFlow()
        
    }

}

// MARK:- Private methods
private extension AppCoordinator {
    
    enum Flow { case loading, auth, general } // ????
    
    func performLoadingFlow() {
        let coordinator = LoadingCoordinator(router: router, factory: factory, apiClient: apiClient)
        coordinator.onCompletion = { [weak self, weak coordinator] in
            self?.childRemove(coordinator)
            self?.selectFlow()
        }
        childAppend(coordinator)
        coordinator.start()
    }
    
    func performAuthFlow() {
        let coordinator = AuthCoordinator(router: router, factory: factory, apiClient: apiClient)
        coordinator.onCompletion = { [weak self, weak coordinator] in
            self?.childRemove(coordinator)
            self?.selectFlow()
        }
        childAppend(coordinator)
        coordinator.start()
    }
    
    func performGeneralFlow() {
        let coordinator = GeneralCoordinator(router: router, factory: factory, apiClient: apiClient)
        coordinator.onCompletion = { [weak self, weak coordinator] in
            self?.childRemove(coordinator)
            self?.selectFlow()
        }
        childAppend(coordinator)
        coordinator.start()
    }
    
}
