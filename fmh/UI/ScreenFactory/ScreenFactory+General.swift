//
//  ScreenFactory+General.swift
//  fmh
//
//  Created: 26.11.2022
//

import Foundation

protocol GeneralScreenFactoryProtocol {
    func makeProfileViewController() -> ProfileViewControllerProtocol
}


//MARK: - GeneralScreenFactoryProtocol
extension ScreenFactory: GeneralScreenFactoryProtocol {
    
    func makeProfileViewController() -> ProfileViewControllerProtocol {
        let controller = ProfileViewController()
        return controller
    }
    
    
}
