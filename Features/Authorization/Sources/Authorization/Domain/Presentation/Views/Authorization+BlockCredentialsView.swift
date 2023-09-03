
import UIKit
import UIComponents

extension AuthorizationViewController {
    
    final class BlockCredentialsView: UIView {
        
        // MARK: Public
        
        var didShouldReturn: (() -> Void)? = nil
        
        // MARK: - UI
        
        private lazy var loginTextField: TextFieldWithState = {
            $0.delegate = self
            $0.title = "Логин"
            $0.textContentType = .nickname
            return $0
        }(TextFieldWithState(configuration: .default))
        
        private lazy var passwordTextField: TextFieldPassword = {
            $0.delegate = self
            $0.title = "Пароль"
            $0.textContentType = .password
            return $0
        }(TextFieldPassword(configuration: .default))
        
        // MARK: Life cycle

        init(greetings: String, greetingsDescription: String) {
            super.init(frame: .zero)
//            self.greetings.text = greetings
//            self.greetingsDescription.text = greetingsDescription
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
                
                passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 8),
                passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                passwordTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -0)
            ]}
        }
    }
}

// MARK: - textFieldShouldReturn

extension AuthorizationViewController.BlockCredentialsView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField { passwordTextField.becomeFirstResponder() }
        if textField == passwordTextField {
            self.endEditing(false)
            didShouldReturn?()
        }
        return true
    }
}
