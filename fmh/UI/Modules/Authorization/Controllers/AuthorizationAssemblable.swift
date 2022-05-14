//
//  AuthorizationAssemblable.swift
//  fmh
//
//  Created: 10.05.2022
//

import Foundation

final class AuthorizationAssembly {
    
    static func assembly(with output: AuthorizationPresenterOutput) {
        
        let repository: AuthRepositoryProtocol = AuthRepository()
        let presenter  = AuthorizationPresenter(repository: repository)
        
        presenter.output     = output
        output.presenter     = presenter
    }
    
}
