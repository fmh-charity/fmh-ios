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

    func makeNewsDetailsViewController(coordinator: GeneralCoordinatorProtocol) -> BaseViewControllerProtocol
    func makeFilterNewsViewController(delegate: AnyObject) -> BaseViewControllerProtocol
    func makeAddNewsViewController(newsId: Int?, transmission: String?) -> BaseViewControllerProtocol
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

    func makeNewsDetailsViewController(coordinator: GeneralCoordinatorProtocol) -> BaseViewControllerProtocol {
        let viewController = NewsDetailsViewController()
        let repository = APIRepositoryNews(apiClient: apiClient)
        let presenter = NewsDetailsPresenter(repository: repository, view: viewController)
        presenter.coordinator = coordinator
        viewController.presenter = presenter
        return viewController
    }

    func makeFilterNewsViewController(delegate: AnyObject) -> BaseViewControllerProtocol {
        let viewController = FilterNewsViewController()
        viewController.delegate = delegate as? FilterNewsDelegate
        return viewController
    }

    func makeAddNewsViewController(newsId: Int?, transmission: String?) -> BaseViewControllerProtocol {
        let viewController = AddNewsViewController()
        let repository = APIRepositoryNews(apiClient: apiClient)
        let userInfo = apiClient.userProfile
        let presenter = AddNewsPresenter(repository: repository, view: viewController, userInfo: userInfo)
        viewController.idNews = newsId
        viewController.destinationName = transmission
        viewController.presenter = presenter
        return viewController
    }
    
    
    func makeProfileViewController() -> ProfileViewControllerProtocol {
        let controller = ProfileViewController()
        return controller
    }
    
    
}
