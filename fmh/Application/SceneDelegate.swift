//
//  SceneDelegate.swift
//  fmh
//
//  Created: 18.04.2022
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    fileprivate lazy var coordinator: Coordinatable = makeCoordinator()
    
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
        let router = Router(window: window)
        let coordinator = AppCoordinator(router: router)
        return coordinator
    }
}
