//
//  ModuleFactory.swift
//  fmh
//
//  Created: 14.05.2022
//

import Foundation

final class ModuleFactory { }

// MARK: - AutorizationModuleFactoryProtocol
extension ModuleFactory: AutorizationModuleFactoryProtocol {
    
    func makeAuthorizationViewController() -> AuthorizationViewController {
        let repository: AuthRepositoryProtocol = AuthRepository()
        let interactor: AuthInteractorProtocol = AuthInteractor(repository: repository)
        let viewController = AuthorizationViewController()
        let presenter  = AuthorizationPresenter(output: viewController)
        
        presenter.interactor = interactor
        viewController.presenter = presenter
        
        return viewController
    }
    
}

// MARK: - LoadingModuleFactoryProtocol
extension ModuleFactory: LoadingModuleFactoryProtocol {
    
    func makeLoadingViewController() -> LoadingViewController {
        let viewController = LoadingViewController()
        let presenter  = LoadingPresenter(output: viewController)
        
        viewController.presenter = presenter
        
        return viewController
    }
    
}

// MARK: - LoadingModuleFactoryProtocol
extension ModuleFactory: GeneralModuleFactoryProtocol {
    
    func makeGeneralViewController() -> GeneralViewController {
        let repository: AuthRepositoryProtocol = AuthRepository()
        let interactor: AuthInteractorProtocol = AuthInteractor(repository: repository)
        let viewController = GeneralViewController()
        let presenter = GeneralPresenter(output: viewController)
        
        presenter.interactor = interactor
        viewController.presenter = presenter
        
        return viewController
    }
    
    func makeTemplateViewController() -> TemplateViewController {
        let viewController = TemplateViewController()
        let presenter  = TemplatePresenter(output: viewController)
        
        viewController.presenter = presenter
        
        return viewController
    }
    

}
