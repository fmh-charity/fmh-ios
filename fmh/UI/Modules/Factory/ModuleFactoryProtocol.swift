//
//  ModuleFactoryProtocol.swift
//  fmh
//
//  Created: 14.05.2022
//

import Foundation

// MARK: - AutorizationModuleFactoryProtocol
protocol AutorizationModuleFactoryProtocol {
    func makeAuthorizationViewController() -> AuthorizationViewController
}

// MARK: - LoadingModuleFactoryProtocol
protocol LoadingModuleFactoryProtocol {
    func makeLoadingViewController() -> LoadingViewController
}

// MARK: - GeneralModuleFactoryProtocol
protocol GeneralModuleFactoryProtocol {
    func makeGeneralViewController() -> GeneralViewController
    
    func makeTemplateViewController() -> TemplateViewController
}


