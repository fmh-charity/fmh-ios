//
//  AppAssembly.swift
//  fmh
//
//  Created: 06.08.2023
//

import Foundation
import Features

final class AppAssembly: AppAssemblyProtocol {
    
    // Dependencies
    let dependencies: AppDependencies
    
    // MARK: - Life cycle
    
    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - AppAssemblyProtocol
    
    // MARK: Сборки Feature модулей.
    lazy var featuresAssembly: FeaturesAssemblyProtocol = {
        FeaturesAssembly(dependencies:
                .init(
                    router: dependencies.router,
                    network: dependencies.network,
                    tokenProvider: dependencies.tokenProvider
                )
        )
    }()
}
