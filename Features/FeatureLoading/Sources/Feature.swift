//
//  Feature.swift
//  
//
//  Created: 02.08.2023
//

import Core
import UIKit

public struct FeatureDependencies {

    var readyToComplete: (() -> Void)?
    
    public init(readyToComplete: (() -> Void)? = nil) {
        self.readyToComplete = readyToComplete
    }
}

// MARK: - Public module

public struct Feature {

    private let assembly: FeatureAssembly
    
    public init(dependencies: FeatureDependencies) {
        self.assembly = FeatureAssembly(dependencies: dependencies)
    }

    public func makeLoadingViewController() -> UIViewController {
        assembly.makeLoadingViewController()
    }
    
    public func startLoadingFlow(_ handler: (UIViewController) -> Void) {
        handler(assembly.makeLoadingViewController())
    }
}

// MARK: - Public module config

public extension Feature {
    
    struct Config {
        
    }
}
