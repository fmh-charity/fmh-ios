//
//  ModuleFactoryProtocol.swift
//  fmh
//
//  Created: 14.05.2022
//

import Foundation

// MARK: - AutorizationModuleFactoryProtocol
protocol AutorizationModuleFactoryProtocol {
    func makeAuthorizationViewController() -> AuthorizationViewControllerProtocol
}

// MARK: - LoadingModuleFactoryProtocol
protocol LoadingModuleFactoryProtocol {
    func makeLoadingViewController() -> LoadingViewControllerProtocol
}

// MARK: - GeneralModuleFactoryProtocol
protocol GeneralModuleFactoryProtocol {
    func makeGeneralViewController() -> GeneralViewControllerProtocol
    
//    func makeNewsListViewController() -> NewsListViewControllerProtocol
    
    func makeOurMissionViewController() -> OurMissionViewControllerProtocol
}


