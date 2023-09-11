
import UIKit
import UIComponents

private extension CGFloat {
    static let navigationExtensionViewHeight: CGFloat = 6.0
}

final class AuthenticationViewController: UIViewController {
    
    // Dependencies
    private let presenter: AuthenticationPresenterProtocol
    
    // Private
    private var blockCredentialsCenterYConstraint: NSLayoutConstraint?
    
    // MARK: - UI
    
    private lazy var navigationExtensionView: UIView = {
        $0.backgroundColor = UIComponents.Color.accent
        $0.heightAnchor.constraint(equalToConstant: .navigationExtensionViewHeight).isActive = true
        return $0
    }(UIView())
    
    private lazy var logo: UIImageView = {
        $0.image = UIImage(named: "Logo", in: .module, with: .none)
        $0.contentMode = .scaleAspectFit
        let height = navigationController?.navigationBar.frame.height ?? 44.0
        $0.heightAnchor.constraint(equalToConstant: height).isActive = true
        return $0
    }(UIImageView())
    
    private lazy var blockInfo: UIView = {
        BlockInfoView(
            greetings: "Добро пожаловать",
            greetingsDescription: "Войдите или зарегистрируйтесь"
        )
    }()
    
    private lazy var blockCredentials: BlockCredentialsView = {
        BlockCredentialsView(
            loginTitle: "Логин",
            loginPlaceholder: "e-mail",
            passwordTitle: "Пароль"
        )
    }()
    
    private lazy var blockButtons: UIView = {
        let button = BlockButtonsView()
        button.didTapLoginButton = { [weak self] in self?.didTapLoginButton() }
        button.didTapRegisterButton = { [weak self] in self?.didTapRegisterButton() }
        return button
    }()
    
    private lazy var topContentView: UIView = UIView()
    private lazy var bottomContentView: UIView = UIView()
    
    // MARK: - Life cycle
    
    init(presenter: AuthenticationPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupUI()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Configure
    
    private func configure() {
        view.backgroundColor = UIComponents.Color.background
        addObserverNotification()
        navigationBarConfigure()
        addTapGestureForKeyboardHide()
    }
    
    private func navigationBarConfigure() {
        navigationItem.titleView = logo
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIComponents.Color.accent
        navigationItem.standardAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        if #available(iOS 15.0, *) {
            navigationItem.compactScrollEdgeAppearance = appearance
        }
    }
    
    private func addObserverNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handlerKeyboardNotification),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handlerKeyboardNotification),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - Setup UI

private extension AuthenticationViewController {
    
    func setupUI() {
        let offset = 20.0
        
        // MARK: navigationExtensionView
        view.addSubviews(navigationExtensionView) {[
            navigationExtensionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationExtensionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationExtensionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]}
        
        // MARK: TopContentView
        view.addSubviews(topContentView, blockInfo) {[
            topContentView.topAnchor.constraint(equalTo: navigationExtensionView.bottomAnchor),
            topContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blockInfo.centerYAnchor.constraint(equalTo: topContentView.centerYAnchor),
            blockInfo.leadingAnchor.constraint(equalTo: topContentView.leadingAnchor),
            blockInfo.trailingAnchor.constraint(equalTo: topContentView.trailingAnchor)
        ]}
        
        // MARK: blockCredentials
        view.addSubviews(blockCredentials) {[
            blockCredentials.topAnchor.constraint(equalTo: topContentView.bottomAnchor),
            blockCredentials.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
            blockCredentials.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset)
        ]}
        blockCredentialsCenterYConstraint = blockCredentials.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: .navigationExtensionViewHeight)
        blockCredentialsCenterYConstraint?.isActive = true
        
        // MARK: BottomContentView
        bottomContentView.addSubview(blockButtons)
        view.addSubviews(bottomContentView) {[
            bottomContentView.topAnchor.constraint(equalTo: blockCredentials.bottomAnchor),
            bottomContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blockButtons.bottomAnchor.constraint(equalTo: bottomContentView.bottomAnchor, constant: -(.safeAreaInsets.bottom + 32)),
            blockButtons.leadingAnchor.constraint(equalTo: bottomContentView.leadingAnchor, constant: offset),
            blockButtons.trailingAnchor.constraint(equalTo: bottomContentView.trailingAnchor, constant: -offset)
        ]}
    }
}

// MARK: - Actions

private extension AuthenticationViewController {
    
    func didTapLoginButton() {
        presenter.login(
            login: blockCredentials.loginText ?? "",
            password: blockCredentials.passwordText ?? ""
        ) { [weak self] error in
            switch error {
            case .loginError(let prompt):
                self?.blockCredentials.setLoginError(prompt)
            case .passwordError(let prompt):
                self?.blockCredentials.setPasswordError(prompt)
            case .requestError:
                self?.blockCredentials.setLoginError("")
                self?.blockCredentials.setPasswordError("")
            }
        }
    }
    
    func didTapRegisterButton() { }
}

// MARK: - handlerKeyboardNotification

private extension AuthenticationViewController {
    
    @objc private func handlerKeyboardNotification(_ notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        var bias: CGFloat = -.navigationExtensionViewHeight
        if notification.name == UIResponder.keyboardWillShowNotification {
            let usedHeight = bottomContentView.frame.height
            let keyboardHeight = keyboardFrame.height
            if keyboardHeight >= usedHeight {
                bias = (keyboardHeight - usedHeight) + 32.0 // 32.0 - От клавиатуры до нижнего края блока полей ввода.
            } else { return }
        }
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.4 ) {
            self.blockCredentialsCenterYConstraint?.constant = -bias
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - Helpers

private extension CGFloat {
    
    static let safeAreaInsets: UIEdgeInsets = {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return scene?.windows.first?.safeAreaInsets ?? .zero
    }()
}

private extension UIViewController {
    
    func addTapGestureForKeyboardHide() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewEndEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func viewEndEditing() {
        view.endEditing(true)
    }
}
