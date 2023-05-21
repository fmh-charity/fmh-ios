//
//  SceneDelegate.swift
//  fmh
//
//  Created: 18.04.2022
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private lazy var coordinator: Coordinatable = makeCoordinator()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            self.window = window
            window.makeKeyAndVisible()
            self.coordinator.start()
        }
        
        func sceneDidDisconnect(_ scene: UIScene) { }
        func sceneDidBecomeActive(_ scene: UIScene) { }
        func sceneWillResignActive(_ scene: UIScene) { }
        func sceneWillEnterForeground(_ scene: UIScene) { }
        func sceneDidEnterBackground(_ scene: UIScene) { }
    }
}

// MARK: - Private methods

private extension SceneDelegate {
    
    func makeCoordinator() -> Coordinatable {
        let apiService = APIService(urlSession: makeSession())
        let tokenProvider = TokenProvider()
        let apiClient = APIClient(service: apiService, tokenProvider: tokenProvider)
        
        let router = Router(window: window, navigationController: NavigationController())
        let coordinator = AppCoordinator(router: router, apiClient: apiClient)
        return coordinator
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
