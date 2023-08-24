//
//  AppDelegate.swift
//  Example
//
//  Created by Константин Туголуков on 07.08.2023.
//

import UIKit
import Authorization

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    lazy var authorizationAssembly: AuthorizationAssemblyProtocol = {
        AuthorizationAssembly(dependencies:
                .init()
        )
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let vc = authorizationAssembly.authorizationViewController
        let nc = UINavigationController(rootViewController: vc)
        window?.rootViewController = nc
        
        return true
    }
}

