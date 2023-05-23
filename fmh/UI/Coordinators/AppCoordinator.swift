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

// MARK: - AppCoordinator

final class AppCoordinator: Coordinator {
    
    private let factory: ScreenFactory
    private let apiClient: APIClientProtocol

    init(router: RouterProtocol, apiClient: APIClientProtocol, factory: ScreenFactory) {
        self.apiClient = apiClient
        self.factory = factory
        super.init(router: router)
    }
    
    override func start() {
        performLoadingFlow()
    }
    
    private func selectFlow() {
        Task(priority: .background) { [weak self] in
            if await self?.apiClient.checkAuthentication() ?? false {
                DispatchQueue.main.async { [weak self] in
                    self?.performGeneralFlow()
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.performAuthFlow()
                }
            }
        }
    }
}

// MARK: - AppCoordinatorProtocol 

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
            Task(priority: .background) { [weak self,  weak coordinator] in
                await self?.apiClient.logout()
                self?.childRemove(coordinator)
                self?.selectFlow()
            }
        }
        childAppend(coordinator)
        coordinator.start()
    }
}
