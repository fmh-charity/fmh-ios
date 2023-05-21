//
//  ScreenFactory+General.swift
//  fmh
//
//  Created: 26.11.2022
//

import Foundation

protocol GeneralScreenFactoryProtocol {
    func makeSideMenuController() -> SideMenuControllerProtocol
    func makeProfileViewController() -> ProfileViewControllerProtocol
    func makeOurMissionViewController() -> OurMissionViewControllerProtocol
}

// MARK: - GeneralScreenFactoryProtocol

extension ScreenFactory: GeneralScreenFactoryProtocol {
    
    func makeSideMenuController() -> SideMenuControllerProtocol {
        let navigationController = NavigationController()
        let presenter = SideMenuPresenter(apiClient: apiClient)
        let controller = SideMenuController(contentController: navigationController, presenter: presenter)
        return controller
    }
    
    func makeOurMissionViewController() -> OurMissionViewControllerProtocol {
        let viewController = OurMissionViewController()
        let presenter = OurMissionPresenter(view: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
    func makeProfileViewController() -> ProfileViewControllerProtocol {
        let controller = ProfileViewController()
        return controller
    }
}
