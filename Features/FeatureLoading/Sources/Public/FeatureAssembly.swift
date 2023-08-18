//
//  File.swift
//  
//
//  Created: 02.08.2023
//

import UIKit

public final class FeatureAssembly {
    
    private let dependencies: FeatureDependencies
    
    public init(dependencies: FeatureDependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - FeatureAssemblyProtocol

extension FeatureAssembly: FeatureAssemblyProtocol {
    
    public var loadingViewController: UIViewController {
        let dataStorage = DataStorage()
        let reachability = Reachability()
        let presenter = LoadingPresenter(dataStorage: dataStorage, reachability: reachability)
        let viewController = LoadingViewController(presenter: presenter)
        presenter.delegate = viewController
        presenter.onCompletion = dependencies.onCompletion
        return viewController
    }
}
