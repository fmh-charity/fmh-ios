//
//  RegistrationViewController.swift
//  fmh
//
//  Created: 16.12.2022
//

import Foundation
import UIKit

protocol RegistrationViewControllerProtocol: BaseViewControllerProtocol {
    
}


final class RegistrationViewController: BaseViewController, RegistrationViewControllerProtocol {
    
    var presenter: RegistrationPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Регистрация"
        configure()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // ...
    }
    
    private func configure() {
        
    }
    
}


//MARK: - RegistrationPresenterDelegate
extension RegistrationViewController: RegistrationPresenterDelegate {
    
}