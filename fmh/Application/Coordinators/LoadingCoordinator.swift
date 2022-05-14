//
//  LoadingCoordinator.swift
//  fmh
//
//  Created: 14.05.2022
//

import Foundation

protocol LoadingCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
}

final class LoadingCoordinator: Coordinator, LoadingCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    fileprivate let factory: LoadingModuleFactoryProtocol
    fileprivate let router : Routable
    
    init(with factory: LoadingModuleFactoryProtocol, router: Routable) {
        self.factory = factory
        self.router  = router
    }
}

// MARK: - Coordinatable
extension LoadingCoordinator: Coordinatable {
    func start() {
        performFlow()
    }
}

// MARK: - Private methods
private extension LoadingCoordinator {
    func performFlow() {
        let view = factory.makeLoadingView()
        view.onCompletion = finishFlow
        router.setRootModule(view, hideBar: true)
    }
}
