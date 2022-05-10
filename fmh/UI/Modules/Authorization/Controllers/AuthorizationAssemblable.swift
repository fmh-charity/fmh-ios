//
//  AuthorizationAssemblable.swift
//  fmh
//
//  Created: 10.05.2022
//

import Foundation

final class AuthorizationAssembly {
    
    static func assembly(with output: AuthorizationPresenterOutput, repository: AuthRepositoryProtocol) {
        
        let presenter  = AuthorizationPresenter(repository: repository)
        
        presenter.output     = output
        output.presenter     = presenter
    }
    
}
