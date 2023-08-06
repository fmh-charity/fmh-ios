//
//  AppAssembly.swift
//  fmh
//
//  Created: 06.08.2023
//

import Foundation
import Core

final class AppAssembly {
    
    let dependencies: AppDependencies
    
    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - AppAssemblyProtocol

extension AppAssembly: AppAssemblyProtocol {
    
    var loadingCoordinator: any Core.Coordinating {
        let dependencies = LoadingDependencies()
        let assembly = LoadingAssembly(dependencies: dependencies)
        return LoadingCoordinator(router: self.dependencies.router, assembly: assembly)
    }
}
