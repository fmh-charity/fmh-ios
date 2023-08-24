//
//  Authorization+BlockCredentials.swift
//  
//
//  Created by Константин Туголуков on 19.08.2023.
//

import UIKit

extension AuthorizationViewController {
    
    final class BlockCredentials: UIView {
        
        // MARK: Life cycle

        init(greetings: String, greetingsDescription: String) {
            super.init(frame: .zero)
            translatesAutoresizingMaskIntoConstraints = false
//            self.greetings.text = greetings
//            self.greetingsDescription.text = greetingsDescription
            setupUI()
        }
       
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - UI
        
        private lazy var login: UITextField = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = .brown
            return $0
        }(UITextField())
        
        private lazy var password: UITextField = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = .brown
            return $0
        }(UITextField())
        
        // MARK: - Setup UI
        
        func setupUI() { 
            addSubview(login)
            addSubview(password)
            NSLayoutConstraint.activate([
                login.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                login.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                login.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                login.heightAnchor.constraint(equalToConstant: 44),
                
                password.topAnchor.constraint(equalTo: login.bottomAnchor, constant: 20),
                password.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                password.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                password.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
                password.heightAnchor.constraint(equalToConstant: 44),
            ])
        }
    }
}
