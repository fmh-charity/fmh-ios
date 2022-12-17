//
//  ForgotPasswordViewController.swift
//  fmh
//
//  Created: 17.12.2022
//

import Foundation
import UIKit

protocol ForgotPasswordViewControllerProtocol: BaseViewControllerProtocol {
    
}


final class ForgotPasswordViewController: BaseViewController, ForgotPasswordViewControllerProtocol {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Восстановление пароля"
        configure()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // ...
    }
    
    private func configure() {
       
    }
    
}
