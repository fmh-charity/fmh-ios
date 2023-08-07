//
//  AppDelegate.swift
//  Example
//
//  Created by Константин Туголуков on 07.08.2023.
//

import UIKit
import FeatureLoading
import Core

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let navigationController = UINavigationController()
        let routingProvider = RoutingProvider(window: window, navigationController: navigationController)
        
        let featureLoading = FeatureLoading.Feature(dependencies: .init(readyToComplete: {
            print("readyToComplete")
        }))
        
        routingProvider.setRootViewController(navigationController)
        
        featureLoading.startLoadingFlow { viewController in
            routingProvider.pushViewController(viewController, animated: false)
        }
        
        return true
    }
}

