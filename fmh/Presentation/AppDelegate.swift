//
//  AppDelegate.swift
//  fmh
//
//  Created: 18.04.2022
//


import UIKit
import Core

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private lazy var coordinator: (any Coordinating)? = {
        let assembly = AppAssembly(dependencies: $0)
        return AppCoordinator(assembly: assembly)
    }(dependencies)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        (coordinator as? AppCoordinator)?.navigate(to: .loading)
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        //        if UserDefaults.standard.bool(forKey: "safeAccount") == false {
        //            TokenProvider.clearTokens()
        //        }
    }
}

// MARK: - AppDependencies

private extension AppDelegate {
    
    var dependencies: AppDependencies {
        
        // Dependencies
        let router = RoutingProvider(window: window, navigationController: UINavigationController())
        
        return AppDependencies(
            router: router
        )
    }
}
