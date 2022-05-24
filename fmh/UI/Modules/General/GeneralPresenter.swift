//
//  GeneralPresenter.swift
//  fmh
//
//  Created: 15.05.2022
//

import Foundation

final class GeneralPresenter {

    weak var output: GeneralPresenterOutput?
    
    var repository: AuthRepositoryProtocol?
    
}

// MARK: - GeneralPresenterInput
extension GeneralPresenter: GeneralPresenterInput {
    
    func getUserInfo() {
        
    }
    
    func logOut() {
        AppSession.logOut()
    }
    
}
