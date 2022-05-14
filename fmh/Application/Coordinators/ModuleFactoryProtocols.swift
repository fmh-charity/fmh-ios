//
//  ModuleFactoryProtocols.swift
//  fmh
//
//  Created: 13.05.2022
//

import Foundation

// MARK: - LoadingModuleFactoryProtocol
protocol LoadingModuleFactoryProtocol {
    func makeLoadingView() -> LoadingViewProtocol
}

// MARK: - AuthorizationViewFactoryProtocol
protocol AuthorizationModuleFactoryProtocol {
    func makeAuthorizationView() -> AuthorizationViewProtocol
}

// MARK: - MainViewFactoryProtocol
protocol MainModuleFactoryProtocol {
    func makeMainView() -> MainViewProtocol
}
