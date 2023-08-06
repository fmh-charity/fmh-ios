//
//  SceneDelegate.swift
//  fmh
//
//  Created: 18.04.2022
//

import UIKit
import Core

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private lazy var coordinator: (any Coordinating)? = makeCoordinator()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            self.window = window
            window.makeKeyAndVisible()
            (coordinator as? AppCoordinator)?.navigate(to: .loading)
        }
    }
}

// MARK: - Private methods

private extension SceneDelegate {
    
    func makeCoordinator() -> any Coordinating {
        let router = RoutingProvider(window: window, navigationController: UINavigationController())
        let dependencies = AppDependencies(router: router)
        let assembly = AppAssembly(dependencies: dependencies)
        return AppCoordinator(assembly: assembly)
    }
    
    func makeCache() -> URLCache {
        let memoryCapacity = 1024 * 1024 * 4
        let diskCapacity = 1024 * 1024 * 20
        let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "ApiClient_Cached")
        return cache
    }
    
    func makeSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringCacheData // .reloadRevalidatingCacheData
        configuration.httpAdditionalHeaders = ["Content-Type" : "application/json"]
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        return session
    }
}
