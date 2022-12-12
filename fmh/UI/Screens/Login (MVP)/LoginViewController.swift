//
//  LoginViewController.swift
//  fmh
//
//  Created: 11.12.2022
//

import Foundation
import UIKit

protocol LoginViewControllerProtocol: BaseViewControllerProtocol {
    
}

final class LoginViewController: BaseViewController, LoginViewControllerProtocol {
    
    //TODO: Возможно в MVC сделать (Если контроллер не сильно большой будет)
    
    var presenter: LoginPresenterProtocol?
    
    private lazy var loginTF: LoginTextField = {
        let view = LoginTextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    private lazy var passwordTF: PasswordTextField = {
        let view = PasswordTextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .accentColor
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return button
    }()
    
    lazy private var stackTF: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [loginTF, passwordTF])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 15.0
        return stack
    }()
    
    private var wraperFormTFCenterYConstraint: NSLayoutConstraint?
    private lazy var wraperForm: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackTF)
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginTF.heightAnchor.constraint(equalToConstant: 40.0),
            passwordTF.heightAnchor.constraint(equalTo: loginTF.heightAnchor),
            
            stackTF.topAnchor.constraint(equalTo: view.topAnchor),
            stackTF.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackTF.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            loginButton.topAnchor.constraint(equalTo: stackTF.bottomAnchor, constant: 30.0),
            loginButton.widthAnchor.constraint(equalTo: stackTF.widthAnchor, multiplier: 0.7),
            loginButton.heightAnchor.constraint(equalTo: passwordTF.heightAnchor),
            loginButton.centerXAnchor.constraint(equalTo: stackTF.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        return view
    }()
    
    //TODO: Сделать общим элементом кастомным с цветом
    private lazy var activityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .accentColor
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private var isProcessing: Bool = false {
        didSet {
            if isProcessing {
                activityIndicator.isHidden = false
                activityIndicator.startAnimating()
            } else {
                activityIndicator.isHidden = true
                activityIndicator.stopAnimating()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Авторизация"
        configure()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    //MARK: - Configure ViewController
    private func configure() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        if let image = UIImage(named: "bacground.main") {
            self.view.backgroundColor  = UIColor(patternImage: image)
        }
        
        self.view.addSubview(wraperForm)
        self.view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            wraperForm.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.8),
            wraperForm.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        wraperFormTFCenterYConstraint = wraperForm.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor)
        wraperFormTFCenterYConstraint?.isActive = true
    }

    
    //MARK: - Actions
    @objc private func keyboardShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?["UIKeyboardFrameBeginUserInfoKey"] as? CGRect {
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.4 ) {
                self.wraperFormTFCenterYConstraint?.constant = -keyboardFrame.height/2
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardHide(notification: NSNotification) {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut ) {
            self.wraperFormTFCenterYConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func loginAction() {
        loginTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        
        if checkFields() {
            isProcessing = true
            guard let textLoginTF = loginTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
            guard let textPasswordTF = passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
            
            presenter?.login(login: textLoginTF, password: textPasswordTF) {[weak self] isOk, errorStr in
                self?.isProcessing = false
                
                if let errorStr = errorStr {
                    self?.showAlert(title: "Ошибка", message: errorStr)
                }
                
                if isOk {
                    self?.onCompletion?()
                }
            }
        }
    }
    
    private func checkFields () -> Bool {
        guard let textLoginTF = loginTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return false }
        guard let textPasswordTF = passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return false }
        
        //loginTF.isInvalid = testLoginTF.isEmpty ? true : false
        
        if textLoginTF.isEmpty && textPasswordTF.isEmpty {
            loginTF.isInvalid = true
            passwordTF.isInvalid = true
            /// Вывод сообщения
            return false
        }
        
        if textLoginTF.isEmpty {
            loginTF.isInvalid = true
            /// Вывод сообщения
            return false
        } else {
            loginTF.isInvalid = false
        }

        if textPasswordTF.isEmpty {
            passwordTF.isInvalid = true
            /// Вывод сообщения
            return false
        } else {
            passwordTF.isInvalid = false
        }
        
        if !textLoginTF.isEmpty && !textPasswordTF.isEmpty {
            return true
        }
        
        return false
    }
    
}


// MARK: - UITextViewDelegate
extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTF { passwordTF.becomeFirstResponder() }
        if textField == passwordTF { loginAction() }
        return true
    }
    
}


// MARK: - LoginPresenterDelegate
extension LoginViewController: LoginPresenterDelegate {
    
}
