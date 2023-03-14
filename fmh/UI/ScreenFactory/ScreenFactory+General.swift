//
//  ScreenFactory+General.swift
//  fmh
//
//  Created: 26.11.2022
//

import Foundation

protocol GeneralScreenFactoryProtocol {
    func makeProfileViewController() -> ProfileViewControllerProtocol
    func makeOurMissionViewController() -> BaseViewControllerProtocol
}

//MARK: - GeneralScreenFactoryProtocol

extension ScreenFactory: GeneralScreenFactoryProtocol {
    
    /// Make OurMission viewController
    func makeOurMissionViewController() -> BaseViewControllerProtocol {
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
