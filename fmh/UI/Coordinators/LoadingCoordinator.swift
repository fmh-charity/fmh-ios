//
//  LoadingCoordinator.swift
//  fmh
//
//  Created: 26.11.2022
//

import Foundation

final class LoadingCoordinator: BaseCoordinator {
    
    fileprivate let factory: LoadingScreenFactoryProtocol
    fileprivate let router: Routable
    
    private var apiClient: APIClientProtocol
    
    init(router: Routable, factory: LoadingScreenFactoryProtocol, apiClient: APIClientProtocol) {
        self.router  = router
        self.factory = factory
        self.apiClient = apiClient
    }
    
    override func start() {
        performLoadingScreenFlow()
    }
    
}

// MARK:- Private methods
private extension LoadingCoordinator {
    
    enum Flow { case loading } // <- Возможно данные передавать еще ...
    
    func performLoadingScreenFlow() {
        let viewController = factory.makeLoadingViewController()
        viewController.onCompletion = onCompletion
        router.setWindowRoot(viewController)
        
        (viewController as? LoadingViewController)?.loadingServiceComplition = true
    }
    
}
