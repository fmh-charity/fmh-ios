//
//  LoginViewController.swift
//  fmh
//
//  Created: 11.12.2022
//

import Foundation
import UIKit

protocol LoginViewControllerProtocol: ViewControllerProtocol {
    var coordinator: AuthCoordinatorProtocol? { get set }
}

final class LoginViewController: ViewController, LoginViewControllerProtocol {
    
    // TODO: Возможно в MVC сделать (Если контроллер не сильно большой будет)
    
    var presenter: LoginPresenterProtocol?
    
    weak var coordinator: AuthCoordinatorProtocol?
    
    private let heightTF: CGFloat = 40.0
    private let heightButtons: CGFloat = 40.0
    
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
        button.layer.cornerRadius = heightButtons/2
        button.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Забыли пароль?", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(forgotAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var safePassfordLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "Сохранить пароль"
        return label
    }()
    
    private lazy var safePassfordSwitch: UISwitch = {
        let _switch = UISwitch()
        _switch.translatesAutoresizingMaskIntoConstraints = false
        _switch.onTintColor = .accentColor
        _switch.setOn(true, animated: false)
        _switch.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        return _switch
    }()
    
    private lazy var safePassfordWrapper: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        view.addSubviews([safePassfordLbl, safePassfordSwitch])
        NSLayoutConstraint.activate([
            safePassfordLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            safePassfordLbl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            safePassfordSwitch.leadingAnchor.constraint(equalTo: safePassfordLbl.trailingAnchor),
            safePassfordSwitch.topAnchor.constraint(equalTo: view.topAnchor),
            safePassfordSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            safePassfordSwitch.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        return view
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .accentColor
        button.layer.cornerRadius = heightButtons/2
        button.addTarget(self, action: #selector(registrationAction), for: .touchUpInside)
        return button
    }()
    
    private var wraperFormTFCenterYConstraint: NSLayoutConstraint?
    private lazy var wraperForm: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        view.addSubviews([loginTF, passwordTF, forgotPasswordButton, safePassfordWrapper, loginButton, registrationButton])
        NSLayoutConstraint.activate([
            loginTF.heightAnchor.constraint(equalToConstant: heightTF),
            loginTF.topAnchor.constraint(equalTo: view.topAnchor),
            loginTF.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginTF.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            passwordTF.heightAnchor.constraint(equalTo: loginTF.heightAnchor),
            passwordTF.topAnchor.constraint(equalTo: loginTF.bottomAnchor, constant: 16),
            passwordTF.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            passwordTF.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 24),
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 8),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            safePassfordWrapper.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 8),
            safePassfordWrapper.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            safePassfordWrapper.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            loginButton.topAnchor.constraint(equalTo: safePassfordSwitch.bottomAnchor, constant: 32),
            loginButton.widthAnchor.constraint(equalTo: passwordTF.widthAnchor, multiplier: 1.0),
            loginButton.heightAnchor.constraint(equalToConstant: heightButtons),
            loginButton.centerXAnchor.constraint(equalTo: passwordTF.centerXAnchor),
            
            registrationButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            registrationButton.widthAnchor.constraint(equalTo: loginButton.widthAnchor),
            registrationButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor),
            registrationButton.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            registrationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        return view
    }()
    
    // TODO: Сделать общим элементом кастомным с цветом
    
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
        title = "Аутентификация" // "Авторизация"
        configure()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    // MARK: - Configure ViewController
    
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

    
    // MARK: - Actions
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
    
    @objc private func registrationAction() {
        coordinator?.performRegistrationScreenFlow()
    }
    
    @objc private func forgotAction() {
        coordinator?.performForgotPasswordScreenFlow()
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
                    UserDefaults.standard.set(self?.safePassfordSwitch.isOn, forKey: "safeAccount")
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
