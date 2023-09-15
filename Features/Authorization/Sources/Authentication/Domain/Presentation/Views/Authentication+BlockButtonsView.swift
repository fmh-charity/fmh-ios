
import UIKit
import UIComponents

extension AuthenticationViewController {
    
    final class BlockButtonsView: UIView {
        
        // MARK: Public
        
        var didTapLoginButton: (() -> Void)? = nil
        var didTapRegisterButton: (() -> Void)? = nil
        
        // MARK: - UI
        
        private lazy var loginButton: Button = {
            $0.title = "Войти"
            $0.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
            return $0
        }(Button(configuration: .primary()))
        
        private lazy var registerButton: Button = {
            $0.title = "Регистрация"
            $0.isEnabled = false
            $0.addTarget(self, action: #selector(registerButtonAction), for: .touchUpInside)
            return $0
        }(Button(configuration: .secondary()))
        
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
        
        private lazy var separatorView: UIView = {
            let view = UIView()
            view.addSubviews(separator, separatorImageView) {[
                separatorImageView.topAnchor.constraint(equalTo: view.topAnchor),
                separatorImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                separatorImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                separator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
                separator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
                separator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ]}
            return view
        }()
        
        private lazy var stackButtons: UIStackView = {
            $0.axis = .vertical
            $0.spacing = 4
            $0.distribution = .equalSpacing
            return $0
        }(UIStackView())
        
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
            stackButtons.addArrangedSubview(loginButton)
            stackButtons.addArrangedSubview(separatorView)
            stackButtons.addArrangedSubview(registerButton)
            
            addSubviews(stackButtons) {[
                stackButtons.topAnchor.constraint(equalTo: topAnchor),
                stackButtons.leadingAnchor.constraint(equalTo: leadingAnchor),
                stackButtons.trailingAnchor.constraint(equalTo: trailingAnchor),
                stackButtons.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]}
        }
        
        // MARK: - Actions
        
        @objc private func loginButtonAction() { didTapLoginButton?() }
        @objc private func registerButtonAction() { didTapRegisterButton?() }
    }
}

// MARK: - ViewCornersAvailable

private extension AuthenticationViewController.BlockButtonsView {
    
    class ViewCorners: UIImageView, ViewCornersAvailable { }
}
