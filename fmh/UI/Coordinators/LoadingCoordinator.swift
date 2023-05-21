//
//  LoadingCoordinator.swift
//  fmh
//
//  Created: 26.11.2022
//

import Foundation

protocol LoadingCoordinatorProtocol: AnyObject {
    func performLoadingScreenFlow()
}

// MARK: - LoadingCoordinator

final class LoadingCoordinator: Coordinator {
    
    weak var parentCoordinator: AppCoordinatorProtocol?
    
    private let factory: LoadingScreenFactoryProtocol
    
    var apiClient: APIClientProtocol?
    
    init(router: Routable, factory: LoadingScreenFactoryProtocol) {
        self.factory = factory
        super.init(router: router)
    }
    
    override func start() {
        performLoadingScreenFlow()
    }
}

// MARK: - LoadingCoordinatorProtocol

extension LoadingCoordinator: LoadingCoordinatorProtocol {
    
    func performLoadingScreenFlow() {
        let viewController = factory.makeLoadingViewController()
        viewController.onCompletion = onCompletion
        router.setWindowRoot(viewController)
        
        // TODO: Если много нужно сервисов опрашивать во время загрузки добавляем очереди/группы
        
        // Если пользователь ранее логинился то обновляем инфу.
        
        Task(priority: .background) { [weak viewController] in
            
            if await apiClient?.checkAuthentication() ?? false {
                
                // fetch user info ... ???
                
                DispatchQueue.main.async { [weak viewController] in
                    viewController?.loadingServiceCompletion(error: nil)
                }
            } else {
                DispatchQueue.main.async { [weak viewController] in
                    viewController?.loadingServiceCompletion(error: nil)
                }
            }
        }
    }
}
