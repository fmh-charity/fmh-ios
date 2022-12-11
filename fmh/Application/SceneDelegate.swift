//
//  SceneDelegate.swift
//  fmh
//
//  Created: 18.04.2022
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    fileprivate var navigationController: UINavigationController {
        let navigationController = UINavigationController()
        let app = UINavigationBarAppearance()
        app.titleTextAttributes = [.foregroundColor: UIColor.white]
        app.backgroundColor = .black
        
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.compactAppearance = app
        navigationController.navigationBar.standardAppearance = app
        navigationController.navigationBar.scrollEdgeAppearance = app
        
        return navigationController
    }
    
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
        
  
       
//        APIClient.shared.login(login: "login1", password: "password1") { error in
//            guard let error = error else {
//                print("ok")
//                print(APIClient.shared.userProfile?.lastName)
//                return
//            }
//
//            print("Error: \(error.localizedDescription)")
//        }
        
//        let d = Plist.loadPropertyList(forResource: "Test")
        
//        TokenManager.del(.accessToken)
//        TokenManager.clear()
//        APIClient.shared.login(login: "login1", password: "password1")
        
//        APIClient.shared.updateUserProfile() { uinf, error  in
//            print("error: \(error)")
//            print(APIClient.shared.userProfile?.firstName)
//        }
    }
    
}


// MARK: - Private methods
private extension SceneDelegate {
    
    func makeCoordinator() -> Coordinatable {
        let router = Router(window: window, navigationController: navigationController)
        let coordinator = AppCoordinator(router: router)
        
        return coordinator
    }
    
}
