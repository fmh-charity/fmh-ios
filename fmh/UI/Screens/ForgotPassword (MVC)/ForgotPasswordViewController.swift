//
//  ForgotPasswordViewController.swift
//  fmh
//
//  Created: 17.12.2022
//

import Foundation
import UIKit

final class ForgotPasswordViewController: ViewController{
    
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
