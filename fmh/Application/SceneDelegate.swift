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
        
        //
        
        let url = URL(string: "https://test.vhospice.org/api/fmh/authentication/userInfo")!
        let request = URLRequest(url: url)
//        Networker.shared.fetch(request: request) { data, response, error in
//            print(response)
//        }
        let token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJsb2dpbjEiLCJqdGkiOiIxIiwiZXhwIjoxNjY5ODI4NzQzfQ.BrtVOrpozXZoN7wnYQ0GjZ888naqWofTvmyngZ51BQmjo0S12VucOgSK1KHaZFxJAxjYBBDtj0S6GLlFnOSI6Q"
        Helper.Core.KeyChain.set(value: token, forKey: "accessToken")
        
        ApiClient.shared.getData(request: request, isWithCached: true) { data, dataType in
            print("data: \(data.jsonObject() as? [String:Any]) : dataType: \(dataType)")
        } onCompletion: { request, response, error in
            print("request: \(request) : response: \(response) : error: \(error)")
        }

    }
    
}


// MARK: - Private methods
private extension SceneDelegate {
    
    func makeCoordinator() -> Coordinatable {
        let router = Router(window: window, navigationController: navigationController)
        let apiClient = ApiClient()
        let factory = ScreenFactory(apiClient: apiClient)
        let coordinator = AppCoordinator(router: router, factory: factory)
        
        return coordinator
    }
    
}
