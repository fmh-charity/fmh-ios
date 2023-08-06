//
//  AppCoordinator.swift
//  fmh
//
//  Created: 06.08.2023
//

import Foundation
import Core

final class AppCoordinator: Coordinating {
    
    private let assembly: AppAssemblyProtocol
    
    init(assembly: AppAssemblyProtocol) {
        self.assembly = assembly
    }
    
    // MARK: - Destinations
    
    enum Destination {
        case loading
    }
    
    func navigate(to destination: Destination) {
        switch destination {
        case .loading: performLoadingFlow()
        }
    }
}

// MARK: - Flows

private extension AppCoordinator {
    
    func performLoadingFlow() {
        (assembly.loadingCoordinator as? LoadingCoordinator)?.navigate(to: .loading)
    }
}
