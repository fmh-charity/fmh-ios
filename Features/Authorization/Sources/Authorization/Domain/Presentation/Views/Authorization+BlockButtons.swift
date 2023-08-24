//
//  Authorization+BlockButtons.swift
//  
//
//  Created by Константин Туголуков on 19.08.2023.
//

import UIKit

extension AuthorizationViewController {
    
    final class BlockButtons: UIView {
        
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
        
        private lazy var login: UIButton = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = .green
            $0.setTitle("login", for: .normal)
            return $0
        }(UIButton(type: .system))
        
        private lazy var register: UIButton = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = .green
            return $0
        }(UIButton())
        
        private lazy var separator: UIView = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.heightAnchor.constraint(equalToConstant: 2).isActive = true
            $0.backgroundColor = .gray
            return $0
        }(UIView())
        
        // MARK: - Setup UI
        
        func setupUI() {
            addSubview(login)
            addSubview(separator)
            addSubview(register)
            NSLayoutConstraint.activate([
                login.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                login.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                login.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                login.heightAnchor.constraint(equalToConstant: 44),
                
                separator.topAnchor.constraint(equalTo: login.bottomAnchor, constant: 16),
                separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                
                register.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 16),
                register.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                register.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                register.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
                register.heightAnchor.constraint(equalToConstant: 44),
            ])
        }
    }
}
