//
//  File.swift
//
//
//  Created: 02.08.2023
//

import UIKit

public final class HomeAssembly {
    
    private let dependencies: HomeDependencies
    
    public init(dependencies: HomeDependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - HomeAssemblyProtocol

extension HomeAssembly: HomeAssemblyProtocol {
    
    public var homeViewController: UIViewController {
       HomeViewController()
    }
}
