//
//  AppDelegateManager.swift
//  fmh
//
//  Created: 08.08.2023
//

import Foundation
import UIKit
import UserNotifications

class AppDelegateManager: NSObject {
    
    // MARK: AppDelegateService
    var appDelegateServices: [AppDelegateService] = []
    
    // MARK: Network monitoring service
    let networkMonitoringService: NetworkMonitoringServiceProtocol
    
    override init() {
        networkMonitoringService = NetworkMonitoringService()
        super.init()
    }
}

    // MARK: - UIApplicationDelegate

extension AppDelegateManager: UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        networkMonitoringService.startMonitoring()
        
        // MARK: Execute appDelegateServices
        let didFinishLaunchingWithOptionsTrue = appDelegateServices.filter {
            $0.application?(application, didFinishLaunchingWithOptions: launchOptions) == false
        }.count == 0
        
        return didFinishLaunchingWithOptionsTrue
    }
    
    // ...
    
}

// MARK: - UNUserNotificationCenterDelegate

extension AppDelegateManager: UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        // MARK: Execute appDelegateServices
        let userActivityTrue = appDelegateServices.filter {
            $0.application?(application, continue: userActivity, restorationHandler: restorationHandler) == true
        }.count > 0
        
        return userActivityTrue
    }
    
    // ...
    
}
