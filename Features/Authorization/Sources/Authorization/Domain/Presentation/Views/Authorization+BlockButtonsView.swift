
import UIKit
import UIComponents

extension AuthorizationViewController {
    
    final class BlockButtonsView: UIView {
        
        // MARK: Public
        
        var didTapLoginButton: (() -> Void)? = nil
        var didTapRegisterButton: (() -> Void)? = nil
        
        // MARK: - UI
        
        private lazy var loginButton: UIComponents.Button = {
            $0.title = "Войти"
            $0.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
            return $0
        }(UIComponents.Button(configuration: .primary.large))
        
        private lazy var registerButton: UIComponents.Button = {
            $0.title = "Регистрация"
            $0.addTarget(self, action: #selector(registerButtonAction), for: .touchUpInside)
            $0.isEnabled = false
            return $0
        }(UIComponents.Button(configuration: .secondary.large))
        
        private lazy var separator: UIView = {
            $0.heightAnchor.constraint(equalToConstant: 1).isActive = true
            $0.backgroundColor = UIColor(red: 0.729, green: 0.729, blue: 0.729, alpha: 1)
            return $0
        }(UIView())
        
        private lazy var separatorImageView: ViewCorners = {
            let image = UIImage(named: "separatorIcon", in: .module, with: .none)
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            let viewCorners = ViewCorners()
            viewCorners.backgroundColor = .white
            viewCorners.corners = .init(radius: 12.0)
            viewCorners.addSubviews(imageView) {[
                imageView.topAnchor.constraint(equalTo: viewCorners.topAnchor, constant: 4),
                imageView.leadingAnchor.constraint(equalTo: viewCorners.leadingAnchor, constant: 4),
                imageView.trailingAnchor.constraint(equalTo: viewCorners.trailingAnchor, constant: -4),
                imageView.bottomAnchor.constraint(equalTo: viewCorners.bottomAnchor, constant: -4),
                viewCorners.widthAnchor.constraint(equalToConstant: 24),
                viewCorners.heightAnchor.constraint(equalToConstant: 24)
            ]}
            return viewCorners
        }()
        
        // MARK: - Life cycle

        init() {
            super.init(frame: .zero)
            translatesAutoresizingMaskIntoConstraints = false
            setupUI()
        }
       
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        // MARK: - Setup UI
        
        func setupUI() {
            addSubviews(loginButton, separator, separatorImageView, registerButton) {[
                loginButton.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                
                separator.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
                separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
                separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
                
                separatorImageView.centerXAnchor.constraint(equalTo: separator.centerXAnchor),
                separatorImageView.centerYAnchor.constraint(equalTo: separator.centerYAnchor),
                
                registerButton.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 16),
                registerButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                registerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                registerButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
            ]}
        }
        
        // MARK: - Actions
        
        @objc private func loginButtonAction() { didTapLoginButton?() }
        @objc private func registerButtonAction() { didTapLoginButton?() }
    }
}

// MARK: - ViewCornersAvailable

private extension AuthorizationViewController.BlockButtonsView {
    
    class ViewCorners: UIImageView, ViewCornersAvailable { }
}
