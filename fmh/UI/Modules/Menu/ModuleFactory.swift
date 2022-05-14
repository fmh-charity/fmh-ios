//
//  ModuleFactory.swift
//  fmh
//
//  Created: 14.05.2022
//

import Foundation

final class ModuleFactory { }


// MARK: -
extension ModuleFactory: AutorizationModuleFactoryProtocol {
    func makeAuthorizationView() -> AuthorizationViewProtocol {
        let viewController: AuthorizationViewController = AuthorizationViewController()
        
        return viewController
    }
}


// MARK: -
extension ModuleFactory {
    
}
