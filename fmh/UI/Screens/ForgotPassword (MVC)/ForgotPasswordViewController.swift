//
//  ForgotPasswordViewController.swift
//  fmh
//
//  Created: 17.12.2022
//

import Foundation
import UIKit

protocol ForgotPasswordViewControllerProtocol: ViewControllerProtocol {
    
}


final class ForgotPasswordViewController: ViewController, ForgotPasswordViewControllerProtocol {
    
    
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
