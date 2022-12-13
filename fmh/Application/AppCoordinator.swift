//
//  AppCoordinator.swift
//  fmh
//
//  Created: 23.11.2022
//

import Foundation

protocol AppCoordinatorProtocol: AnyObject {
    
    func performLoadingFlow()
    func performAuthFlow()
    func performGeneralFlow()
    
}


final class AppCoordinator: BaseCoordinator {
    
    private lazy var factory: ScreenFactory = ScreenFactory(apiClient: apiClient)
    
    private lazy var apiClient: APIClientProtocol = {
        let apiClient =  APIClient(urlSession: self.session)
        apiClient.urlSession.configuration.urlCache = self.cache
        
        // В случае ошибки какой в API - перекидываем на ввод логина
        apiClient.didCaseInterruption = { [weak self] userInfo in
            self?.childCoordinators = []
            self?.performAuthFlow()
        }
        return apiClient
    }()
    
    override func start() {
        performLoadingFlow()
    }
    
    private func selectFlow() {
        apiClient.isAuthorized() ? performGeneralFlow() : performAuthFlow()
    }

}

// MARK: AppCoordinatorProtocol -
extension AppCoordinator: AppCoordinatorProtocol {

    func performLoadingFlow() {
        let coordinator = LoadingCoordinator(router: router, factory: factory)
        coordinator.parentCoordinator = self
        coordinator.apiClient = apiClient
        coordinator.onCompletion = { [weak self, weak coordinator] in
            self?.childRemove(coordinator)
            self?.selectFlow()
        }
        childAppend(coordinator)
        coordinator.start()
    }
    
    func performAuthFlow() {
        let coordinator = AuthCoordinator(router: router, factory: factory)
        coordinator.parentCoordinator = self
        coordinator.onCompletion = { [weak self, weak coordinator] in
            self?.childRemove(coordinator)
            self?.selectFlow()
        }
        childAppend(coordinator)
        coordinator.start()
    }
    
    func performGeneralFlow() {
        let coordinator = GeneralCoordinator(router: router, factory: factory)
        coordinator.parentCoordinator = self
        coordinator.apiClient = apiClient
        coordinator.onCompletion = { [weak self, weak coordinator] in
            self?.apiClient.logout()
            self?.childRemove(coordinator)
            self?.selectFlow()
        }
        childAppend(coordinator)
        coordinator.start()
    }
    
}


//MARK: - Cache
fileprivate extension AppCoordinator {
    
     var cache: URLCache {
        let memoryCapacity = 1024 * 1024 * 4
        let diskCapacity = 1024 * 1024 * 20
        let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "ApiClient_Cached")
        return cache
    }
    
    var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringCacheData // .reloadRevalidatingCacheData
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        return session
    }
    
}
