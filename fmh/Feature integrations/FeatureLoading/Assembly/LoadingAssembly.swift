//
//  LoadingAssembly.swift
//  fmh
//
//  Created: 06.08.2023
//

import UIKit
import FeatureLoading

final class LoadingAssembly {
    
    let dependencies: LoadingDependencies
    
    init(dependencies: LoadingDependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - FeatureLoadingAssembly

extension LoadingAssembly: LoadingAssemblyProtocol {
    
    var loadingViewController: UIViewController {
        let dependencies = FeatureLoading.FeatureDependencies(readyToComplete: dependencies.readyToComplete)
        return FeatureLoading.Feature(dependencies: dependencies).makeLoadingViewController()
    }
}
