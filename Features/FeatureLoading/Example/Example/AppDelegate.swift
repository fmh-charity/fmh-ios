//
//  AppDelegate.swift
//  Example
//
//  Created by Константин Туголуков on 07.08.2023.
//

import UIKit
import FeatureLoading

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    lazy var featureAssembly: FeatureAssemblyProtocol = {
        FeatureAssembly(dependencies:
                .init(onCompletion: {
                    print("onCompletion")
                })
        )
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let vc = featureAssembly.loadingViewController
        window?.rootViewController = vc
        
        return true
    }
}

