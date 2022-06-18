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
    
    func makeAuthorizationViewController() -> AuthorizationViewControllerProtocol {
        let repository = AuthRepository()
        let interactor = AuthInteractor(repository: repository)
        let viewController = AuthorizationViewController()
        let presenter  = AuthorizationPresenter(output: viewController)
        
        presenter.interactor = interactor
        viewController.presenter = presenter
        
        return viewController
    }
    
}

// MARK: - LoadingModuleFactoryProtocol
extension ModuleFactory: LoadingModuleFactoryProtocol {
    
    func makeLoadingViewController() -> LoadingViewControllerProtocol {
        let viewController = LoadingViewController()
        let presenter  = LoadingPresenter(output: viewController)
        
        viewController.presenter = presenter
        
        return viewController
    }
    
}

// MARK: - LoadingModuleFactoryProtocol
extension ModuleFactory: GeneralModuleFactoryProtocol {
    
    func makeGeneralViewController() -> GeneralViewControllerProtocol {
        let repository = AuthRepository()
        let interactor = AuthInteractor(repository: repository)
        let viewController = GeneralViewController()
        let presenter = GeneralPresenter(output: viewController)
        
        presenter.interactor = interactor
        viewController.presenter = presenter
        
        return viewController
    }
    
    func makeTemplateViewController() -> TemplateViewControllerProtocol {
        let repository = NewsRepository()
        let interactor = NewsInteractor(repository: repository)
        let viewController = TemplateViewController()
        let presenter = TemplatePresenter(interactor: interactor, output: viewController)
        viewController.presenter = presenter
        
        return viewController
    }
    

}
