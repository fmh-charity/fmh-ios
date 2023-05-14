//
//  RegistrationPresenter.swift
//  fmh
//
//  Created: 16.12.2022
//

import Foundation

protocol RegistrationPresenterProtocol {
    
}

protocol RegistrationPresenterDelegate: AnyObject {
    
}

final class RegistrationPresenter {
    
    weak private var view: RegistrationPresenterDelegate?
    
    init(with view: RegistrationPresenterDelegate) {
        self.view = view
    }
}


// MARK: - RegistrationPresenterProtocol
extension RegistrationPresenter: RegistrationPresenterProtocol {
    
}
