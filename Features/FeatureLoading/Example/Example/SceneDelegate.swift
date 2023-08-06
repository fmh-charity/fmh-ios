//
//  SceneDelegate.swift
//  Example
//
//  Created by Константин Туголуков on 05.08.2023.
//

import UIKit
import FeatureLoading
import Core

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = .init(windowScene: windowScene)
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
        
    }
    
    
}

