//
//  LoginView.swift
//  fmh
//
//  Created: 02.05.2022
//

import UIKit

class LoginView: UIView {
    
    var frameCenterYConstraint: NSLayoutConstraint?
    
    // MARK: - Elements
    lazy private var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 15.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    lazy var loginTF: LoginTextfield = {
        let textField = LoginTextfield()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var passwordTF: PasswordTextfield = {
        let textField = PasswordTextfield()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .accentColor
        button.layer.cornerRadius = 5.0
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var activityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .accentColor
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented, LoginView")
    }
    
    // MARK: - Private functions
    private func commonInit () {
        if let image = UIImage(named: "BackGround") {
            self.backgroundColor  = UIColor(patternImage: image)
        }
        setLayout()
    }
    
    private func setLayout() {
        
        let marginsView = self.layoutMarginsGuide
        
        let frame = UIView()
        frame.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(frame)
        NSLayoutConstraint.activate([
            frame.widthAnchor.constraint(equalTo: marginsView.widthAnchor, multiplier: 0.8),
            frame.centerXAnchor.constraint(equalTo: marginsView.centerXAnchor)
        ])
        frameCenterYConstraint = frame.centerYAnchor.constraint(equalTo: marginsView.centerYAnchor)
        frameCenterYConstraint?.isActive = true
        
        [loginTF, passwordTF].forEach{ stack.addArrangedSubview($0) }
        NSLayoutConstraint.activate([
            loginTF.heightAnchor.constraint(equalToConstant: 40.0),
            passwordTF.heightAnchor.constraint(equalTo: loginTF.heightAnchor)
        ])
        
        frame.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: frame.topAnchor),
            stack.leadingAnchor.constraint(equalTo: frame.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: frame.trailingAnchor)
        ])
        
        frame.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 30.0),
            loginButton.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.7),
            loginButton.heightAnchor.constraint(equalTo: loginTF.heightAnchor),
            loginButton.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: frame.bottomAnchor)
        ])
 
        self.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: marginsView.topAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: leadingAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            activityIndicator.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
    }

}
