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


final class LoadingCoordinator: BaseCoordinator {
    
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

// MARK: LoadingCoordinatorProtocol -
extension LoadingCoordinator: LoadingCoordinatorProtocol {

    func performLoadingScreenFlow() {
        let viewController = factory.makeLoadingViewController()
        viewController.onCompletion = onCompletion
        router.setWindowRoot(viewController)
    
        //TODO: Если много нужно сервисов опрашивать во время загрузки добавляем очереди/группы
        
        // Проверяем авторизацию + обновляем информацию о пользователе.
    
        apiClient?.updateUserProfile { [weak viewController] userProfile, error in
            (viewController as? LoadingViewController)?.loadingServiceComplition = true
        }
        
    }
    
}
