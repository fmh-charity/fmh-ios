//
//  ScreenFactory+General.swift
//  fmh
//
//  Created: 26.11.2022
//

import Foundation

protocol GeneralScreenFactoryProtocol {
    func makeProfileViewController() -> ViewControllerProtocol
    func makeOurMissionViewController() -> ViewControllerProtocol
}

// MARK: - GeneralScreenFactoryProtocol

extension ScreenFactory: GeneralScreenFactoryProtocol {
    
    func makeOurMissionViewController() -> ViewControllerProtocol {
        let viewController = OurMissionViewController()
        let presenter = OurMissionPresenter(view: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
    func makeProfileViewController() -> ViewControllerProtocol {
        let controller = ProfileViewController()
        return controller
    }
}
