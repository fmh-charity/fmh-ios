//
//  LoginView.swift
//  fmh
//
//  Created: 02.05.2022
//

import UIKit

class LoginView: UIView {
    
    var frameCenterYConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super .init(coder: coder)
        commonInit()
    }
    
    // MARK: - Private functions
    private func commonInit () {
        setBackground()
        setLayout()
    }
    
    private func setBackground () {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BackGround")
        imageView.contentMode = .scaleToFill
        self.addSubview(imageView)
        self.sendSubviewToBack(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setLayout() {
        
        let frame = UIView()
        frame.translatesAutoresizingMaskIntoConstraints = false

        [loginTF, passwordTF].forEach{ stack.addArrangedSubview($0) }
        
        frame.addSubview(stack)
        frame.addSubview(loginButton)
        
        self.addSubview(frame)
        
        let marginsView = self.layoutMarginsGuide
        NSLayoutConstraint.activate([
            frame.widthAnchor.constraint(equalTo: marginsView.widthAnchor, multiplier: 0.8),
            frame.centerXAnchor.constraint(equalTo: marginsView.centerXAnchor)
        ])
        frameCenterYConstraint = frame.centerYAnchor.constraint(equalTo: marginsView.centerYAnchor)
        frameCenterYConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            loginTF.heightAnchor.constraint(equalToConstant: 40.0),
            passwordTF.heightAnchor.constraint(equalTo: loginTF.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: frame.topAnchor),
            stack.leadingAnchor.constraint(equalTo: frame.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: frame.trailingAnchor)
        ])
        
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
    
    // MARK: - Elements
    private var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 15.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    var loginTF: LoginTextfield = {
        let textField = LoginTextfield()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    var passwordTF: PasswordTextfield = {
        let textField = PasswordTextfield()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .init(named: "AccentColor")
        button.layer.cornerRadius = 5.0
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var activityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .init(named: "AccentColor")
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
    }()
    
}


// MARK: - SwiftUI Representable
#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ViewRepresentable: UIViewRepresentable {
    
    func makeUIView(context: Context) -> some UIView {
        return LoginView()
    }
    
    func updateUIView(_ uiViewController: UIViewType, context: Context) {
        
    }
}

struct View_Preview: PreviewProvider {
    static var previews: some View {
        ViewRepresentable()
            //.frame(width: 290, height: 170, alignment: .center)
    }
}
#endif
