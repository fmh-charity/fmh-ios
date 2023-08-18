//
//  AppDelegate.swift
//  fmh
//
//  Created: 18.04.2022
//

import UIKit
import Coordinating

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
        
        // Root router
        let rootRouter = RouterProvider(window: window, navigationController: UINavigationController())
        
        return AppDependencies(
            router: rootRouter
        )
    }
}
