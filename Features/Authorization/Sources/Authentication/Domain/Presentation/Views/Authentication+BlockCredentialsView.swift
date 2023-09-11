
import UIKit
import UIComponents

extension AuthenticationViewController {
    
    final class BlockCredentialsView: UIView {
        
        // MARK: Public
        
        var loginText: String? {
            loginTextField.text
        }
        
        var passwordText: String? {
            passwordTextField.text
        }
        
        var didShouldReturn: (() -> Void)? = nil
        
        // MARK: - UI
        
        private lazy var loginTextField: TextField = {
            $0.delegate = self
            $0.text = "medhospis0@gmail.com"
            $0.textContentType = .nickname
            return $0
        }(TextField())
        
        private lazy var passwordTextField: TextFieldPassword = {
            $0.delegate = self
            $0.text = "medhos123"
            $0.textContentType = .password
            return $0
        }(TextFieldPassword(configuration: .default()))
        
        // MARK: Life cycle

        init(loginTitle: String, loginPlaceholder: String, passwordTitle: String) {
            super.init(frame: .zero)
            self.loginTextField.title = loginTitle
            self.loginTextField.placeholder = loginPlaceholder
            self.passwordTextField.title = passwordTitle
            setupUI()
        }
       
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Setup UI
        
        func setupUI() {
            addSubviews(loginTextField, passwordTextField) {[
                loginTextField.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                loginTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                loginTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 16),
                passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                passwordTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -0)
            ]}
        }
    }
}

// MARK: - textFieldShouldReturn

extension AuthenticationViewController.BlockCredentialsView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField { passwordTextField.becomeFirstResponder() }
        if textField == passwordTextField {
            self.endEditing(false)
            didShouldReturn?()
        }
        return true
    }
}

// MARK: - Set errors

extension AuthenticationViewController.BlockCredentialsView {

    func setLoginError(_ prompt: String) {
        loginTextField.setState(.error)
        loginTextField.prompt = prompt
    }
    
    func setPasswordError(_ prompt: String) {
        passwordTextField.setState(.error)
        passwordTextField.prompt = prompt
    }
}
