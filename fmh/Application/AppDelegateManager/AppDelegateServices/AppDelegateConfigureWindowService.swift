//
//  AppDelegateConfigureService.swift
//  fmh
//
//  Created: 09.08.2023
//

import Foundation
import UIKit

final class AppDelegateConfigureService: NSObject, AppDelegateService {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("unable to get UIApplication and UIApplicationDelegate.")
        }
        
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window?.makeKeyAndVisible()
        
        appDelegate.appCoordinator.startFlow()
 
        return true
    }
}
