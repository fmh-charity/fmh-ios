//
//  ScreenFactory+.swift
//  fmh
//
//  Created: 26.11.2022
//

import Foundation

protocol AuthScreenFactoryProtocol {
    func makeLoginViewController() -> LoginViewControllerProtocol
}


//MARK: - AuthScreenFactoryProtocol
extension ScreenFactory: AuthScreenFactoryProtocol {
    
    func makeLoginViewController() -> LoginViewControllerProtocol {
        let repository = AuthRepository(apiClient: apiClient)
        let viewController = LoginViewController()
        let presenter = LoginPresenter(repository: repository, with: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
}
