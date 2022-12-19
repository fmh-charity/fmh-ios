//
//  UIModuleFactory.swift
//  fmh
//
//  Created: 14.05.2022
//

import Foundation

final class UIModuleFactory {
    
    private let apiService: APIURLSessionServiceProtocol
    
    init(apiService: APIURLSessionServiceProtocol) {
        self.apiService = apiService
    }
    
}


//TODO: - НАДО ПРОДУМАТЬ ПРОСТАВЛЕНИЕ ВЗАИМОСВЯЗЕЙ !!!


// MARK: Сборка модулей для экранов (которые в меню) ... -

// MARK: - AutorizationModuleFactoryProtocol
extension UIModuleFactory: UIModuleFactoryAutorizationProtocol {
    
    // Make Autorization viewController
    func makeUIModuleAutorizationViewController() -> FMHUIViewControllerBaseProtocol {
        let repository = APIRepositoryAuthentication(service: apiService)
        let viewController = UIModuleAutorizationViewController()
        let presenter = UIModuleAutorizationPresenter(repository: repository, with: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
}


// MARK: - LoadingModuleFactoryProtocol
extension UIModuleFactory: UIModuleFactoryLoadingProtocol {
    func makeLoadingViewController() -> FMHUIViewControllerBaseProtocol {
        let viewController = UIModuleLoadingViewController()
        return viewController
    }
}


// MARK: - UIModuleFactoryGeneralProtocol
extension UIModuleFactory: UIModuleFactoryGeneralProtocol {
    
    /// Make OurMission viewController
    func makeUIModuleOurMissionViewController() -> FMHUIViewControllerBaseProtocol {
        let viewController = UIModuleOurMissionViewController()
        let presenter = UIModuleOurMissionPresenter(view: viewController)
        viewController.presenter = presenter
        return viewController
    }
    /// Make news viewController
    func makeUIModuleNewsViewController(router: UICoordinatorGeneralTransitions) -> FMHUIViewControllerBaseProtocol {
        let viewController = UIModuleNewsListViewController()
        let repository = APIRepositoryNews(service: apiService)
        let isAdmin = apiService.userInfo?.isAdmin ?? false
        let presenter = UIModuleNewsListPresenter(repository: repository, view: viewController, router: router, isAdmin: isAdmin)
        viewController.presenter = presenter
        return viewController
    }
    /// Make patients viewController
    func makeUIModulePatientsViewController() -> FMHUIViewControllerBaseProtocol {
        let viewController = UIModulePatientsViewController()
        let repository = APIRepositoryPatients(service: apiService)
        let presenter = UIModulePatientsPresenter(repository: repository, view: viewController)
        viewController.presenter = presenter
        return viewController
    }
    /// Make wishes viewController
    func makeUIModuleWishesViewController(router: UICoordinatorGeneralTransitions) -> FMHUIViewControllerBaseProtocol {
        let viewController = UIModuleWishesMainViewController()
        let repository = APIRepositoryWishes(service: apiService)
        let router = router
        let viewModel = UIModuleWishesViewModel(repository: repository, router: router)
        viewController.viewModel = viewModel
        return viewController
    }
    
    /// Make claims viewController
    func makeUIModuleClaimsViewController() -> FMHUIViewControllerBaseProtocol {
      let viewController = TaskViewController()
        return viewController
    }
}


// MARK: Сборка модулей для дочерних экранов ... -

// MARK: - UIModuleFactoryAdmissionsRouting
extension UIModuleFactory: UIModuleFactoryAdmissionsRouting {
    // ...
}

// MARK: - UIModuleFactoryAdmissionsRouting
extension UIModuleFactory: UIModuleFactoryClaimsRouting {
    // ...
}

// MARK: - UIModuleFactoryAdmissionsRouting
extension UIModuleFactory: UIModuleFactoryNewsRouting {
    func makeUIModuleAddNewsViewController() -> FMHUIViewControllerBaseProtocol {
        let viewController = UIModuleAddNewsViewController()
        let repository = APIRepositoryNews(service: apiService)
        let userInfo = apiService.userInfo
        let presenter = UIModuleAddNewsPresenter(repository: repository, view: viewController, userInfo: userInfo)
        viewController.presenter = presenter
        return viewController
    }
    
    func makeUIModuleFilterNewsViewController() -> FMHUIViewControllerBaseProtocol {
        let viewController = UIModuleFilterNewsViewController()
        return viewController
    }
    
    func makeUIModuleNewsDetailsViewController(router: UICoordinatorGeneralTransitions) -> FMHUIViewControllerBaseProtocol {
        let viewController = UIModuleNewsDetailsViewController()
        let repository = APIRepositoryNews(service: apiService)
        let router = router
        let presenter = UIModuleNewsDetailsPresenter(repository: repository, view: viewController, router: router)
        viewController.presenter = presenter
        return viewController
    }
    
    /// Make news child viewController
    func makeUIModuleNewsChildViewController() -> FMHUIViewControllerBaseProtocol {
        return FMHUIViewControllerBase() // <- temp
    }
    
    
    // ...
}

// MARK: - UIModuleFactoryAdmissionsRouting
extension UIModuleFactory: UIModuleFactoryNurseStationRouting {
    // ...
}

// MARK: - UIModuleFactoryAdmissionsRouting
extension UIModuleFactory: UIModuleFactoryPatientsRouting {
    // ...
}

// MARK: - UIModuleFactoryAdmissionsRouting
extension UIModuleFactory: UIModuleFactoryUsersRouting {
    // ...
}

// MARK: - UIModuleFactoryAdmissionsRouting
extension UIModuleFactory: UIModuleFactoryWishesRouting {
    
    func makeUIModuleWishDetailViewConstroller() -> FMHUIViewControllerBaseProtocol {
        let viewController = UIModuleWishDetailViewController()
        return viewController
    }
    // ...
}
