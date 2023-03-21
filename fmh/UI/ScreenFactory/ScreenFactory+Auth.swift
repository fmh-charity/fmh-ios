//
//  ScreenFactory+.swift
//  fmh
//
//  Created: 26.11.2022
//

import Foundation

protocol AuthScreenFactoryProtocol {
    func makeLoginViewController() -> LoginViewControllerProtocol
    func makeRegistrationViewController() -> RegistrationViewControllerProtocol
    func makeForgotPasswordViewController() -> ForgotPasswordViewControllerProtocol
}

// MARK: - AuthScreenFactoryProtocol

extension ScreenFactory: AuthScreenFactoryProtocol {

    func makeLoginViewController() -> LoginViewControllerProtocol {
        let viewController = LoginViewController()
        let presenter = LoginPresenter(apiClient: apiClient, with: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
    func makeRegistrationViewController() -> RegistrationViewControllerProtocol {
        let viewController = RegistrationViewController()
        let presenter = RegistrationPresenter(with: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
    func makeForgotPasswordViewController() -> ForgotPasswordViewControllerProtocol {
        let viewController = ForgotPasswordViewController()
        return viewController
    }
}
