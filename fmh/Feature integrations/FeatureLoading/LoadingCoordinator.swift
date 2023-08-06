//
//  LoadingCoordinator.swift
//  fmh
//
//  Created: 06.08.2023
//

import Foundation
import Core

final class LoadingCoordinator: Coordinating {
    
    private let router: Routing
    private let assembly: LoadingAssemblyProtocol
    
    init(router: Routing, assembly: LoadingAssemblyProtocol) {
        self.router = router
        self.assembly = assembly
    }
    
    // MARK: - Destinations
    
    enum Destination {
        case loading
    }
    
    func navigate(to destination: Destination) {
        switch destination {
        case .loading:
            router.setRootViewController(assembly.loadingViewController)
        }
    }
}
