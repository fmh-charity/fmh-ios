//
//  AppDelegate.swift
//  fmh
//
//  Created: 18.04.2022
//

import UIKit
import Coordinating
import Networking

@main
class AppDelegate: AppDelegateManager {
    
    // MARK: Public
    var window: UIWindow?
    
    /// Сборки приложения.
    private(set) lazy var appAssembly: AppAssemblyProtocol = {
        AppAssembly(dependencies: dependencies)
    }()
    
    /// Координатор приложения.
    private(set) lazy var appCoordinator: (any CoordinatorProtocol & NavigateFlowProtocol & DeeplinkProtocol) = {
        AppCoordinator(appAssembly: appAssembly)
    }()
    
    // MARK: - LifeCycle
    
    override init() {
        super.init()
        
        // MARK: AppDelegate services
        appDelegateServices.append(AppDelegateConfigureService())
    }
}

// MARK: - AppDependencies

private extension AppDelegate {
    
    /// Зависимости приложения.
    var dependencies: AppDependencies {
        
        let rootRouter = RouterProvider(window: window, navigationController: UINavigationController())
        let network = NetworkingProvider(host: "https://test.vhospice.org", urlSession: .shared)
        let tokenProvider = TokenProvider()
        
        return AppDependencies(
            router: rootRouter,
            network: network,
            tokenProvider: tokenProvider
        )
    }
}
