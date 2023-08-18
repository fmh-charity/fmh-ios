//
//  AppCoordinator.swift
//  fmh
//
//  Created: 06.08.2023
//

import Foundation
import Coordinating
import Features

final class AppCoordinator: CoordinatorProtocol, DeeplinkProtocol {
    
    // Dependencies
    private let appAssembly: AppAssemblyProtocol
    
    // Public for Protocols
    var childCoordinators: [CoordinatorProtocol] = []
    var onCompletion: (() -> Void)?
    var rootCoordinator: DeeplinkProtocol?
    
    // MARK: - Life cycle
    
    init(appAssembly: AppAssemblyProtocol) {
        self.appAssembly = appAssembly
    }
    
    // MARK: CoordinatorProtocol
    
    func startFlow() {
        navigate(to: .loading)
    }
    
    // MARK: DeeplinkProtocol
    
    func navigate(to deepLink: Deeplink) {
        
        // ...
        
        if let rootCoordinator {
            rootCoordinator.navigate(to: deepLink)
        }
    }
    
    // MARK: - Select flow
    
    private func defineFlow() {
        print("defineFlow")
    }
}

// MARK: - NavigateFlowProtocol

extension AppCoordinator: NavigateFlowProtocol {
    
    enum Flow {
        case loading
    }
    
    // MARK: Navigate to flow
    
    func navigate(to flow: Flow) {
        switch flow {
        case .loading: performLoadingFlow()
        }
    }
}

// MARK: - Flows

private extension AppCoordinator {
    
    func performLoadingFlow() {
        let coordinator = appAssembly.featuresAssembly.loadingCoordinator
        childCoordinatorAppend(coordinator)
        coordinator.onCompletion = { [weak self, weak coordinator] in
            self?.childCoordinatorRemove(coordinator)
            self?.defineFlow()
        }
        coordinator.startFlow()
    }
}
