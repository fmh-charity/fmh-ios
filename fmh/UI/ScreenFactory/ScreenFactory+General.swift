//
//  ScreenFactory+General.swift
//  fmh
//
//  Created: 26.11.2022
//

import Foundation

protocol GeneralScreenFactoryProtocol {
    func makeProfileViewController() -> ProfileViewControllerProtocol
    
    func makeNewsListViewController(coordinator: GeneralCoordinatorProtocol) -> BaseViewControllerProtocol

    func makeNewsDetailsViewController() -> BaseViewControllerProtocol
    func makeFilterNewsViewController() -> BaseViewControllerProtocol
    func makeAddNewsViewController() -> BaseViewControllerProtocol
}


//MARK: - GeneralScreenFactoryProtocol
extension ScreenFactory: GeneralScreenFactoryProtocol {

    /// Make news viewController
    func makeNewsListViewController(coordinator: GeneralCoordinatorProtocol) -> BaseViewControllerProtocol {
        let viewController = NewsListViewController()
        let repository = APIRepositoryNews(apiClient: apiClient)
        let isAdmin = apiClient.userProfile?.isAdmin ?? false
        let presenter = NewsListPresenter(repository: repository, view: viewController, isAdmin: isAdmin)
        presenter.coordinator = coordinator
        viewController.presenter = presenter
        return viewController
    }

    func makeNewsDetailsViewController() -> BaseViewControllerProtocol {
        let viewController = NewsDetailsViewController()
        let repository = APIRepositoryNews(apiClient: apiClient)
        let presenter = NewsDetailsPresenter(repository: repository, view: viewController)
        viewController.presenter = presenter
        return viewController
    }

    func makeFilterNewsViewController() -> BaseViewControllerProtocol {
        let viewController = FilterNewsViewController()
        return viewController
    }

    func makeAddNewsViewController() -> BaseViewControllerProtocol {
        let viewController = AddNewsViewController()
        let repository = APIRepositoryNews(apiClient: apiClient)
        let userInfo = apiClient.userProfile
        let presenter = AddNewsPresenter(repository: repository, view: viewController, userInfo: userInfo)
        viewController.presenter = presenter
        return viewController
    }
    
    
    func makeProfileViewController() -> ProfileViewControllerProtocol {
        let controller = ProfileViewController()
        return controller
    }
    
    
}
