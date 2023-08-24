//
//  AuthorizationViewController.swift
//  
//
//  Created by Константин Туголуков on 19.08.2023.
//

import UIKit

final class AuthorizationViewController: UIViewController {
    
    // Dependencies
    private let presenter: AuthorizationPresenterProtocol
    
    private var blockCredentialsCenterYConstraint: NSLayoutConstraint?
    
    // MARK: Life cycle
    init(presenter: AuthorizationPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configure()
    }
    
    // MARK: - Configure
    
    func configure() {
        addTapGestureForKeyboardHide()
        NotificationCenter.default.addObserver(self, selector: #selector(handlerNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handlerNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        
//        navigationController?.navigationBar.backgroundColor = .brown
        view.backgroundColor = UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1)
        
        navigationItem.titleView = logo
    }
    
    // MARK: - UI
    
    private lazy var logo: UIImageView = {
        $0.image = UIImage(named: "Logo", in: .module, with: .none)
        $0.contentMode = .scaleAspectFit
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return $0
    }(UIImageView())
    
    private lazy var blockInfo: UIView = {
        BlockInfo(
            greetings: "Добро пожаловать",
            greetingsDescription: "Войдите или зарегистрируйтесь"
        )
    }()
    
    private lazy var blockCredentials: UIView = {
        BlockCredentials(
            greetings: "Добро пожаловать",
            greetingsDescription: "Войдите или зарегистрируйтесь"
        )
    }()
    
    private lazy var blockButtons: UIView = {
        BlockButtons(
            greetings: "Добро пожаловать",
            greetingsDescription: "Войдите или зарегистрируйтесь"
        )
    }()
    
    private lazy var wrapperBlockInfo: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addSubview(blockInfo)
        NSLayoutConstraint.activate([
            blockInfo.centerYAnchor.constraint(equalTo: $0.centerYAnchor, constant: 0),
            blockInfo.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 0),
            blockInfo.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: 0),
        ])
        return $0
    }(UIView())
}

// MARK: - Setup UI

private extension AuthorizationViewController {
    
    func setupUI() {
        view.addSubview(wrapperBlockInfo)
        view.addSubview(blockCredentials)
        view.addSubview(blockButtons)
        NSLayoutConstraint.activate([
            wrapperBlockInfo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            wrapperBlockInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            wrapperBlockInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            blockCredentials.topAnchor.constraint(equalTo: wrapperBlockInfo.bottomAnchor),
            blockCredentials.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            blockCredentials.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            blockButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            blockButtons.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            blockButtons.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -36),
        ])
        blockCredentialsCenterYConstraint = blockCredentials.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        blockCredentialsCenterYConstraint?.isActive = true
    }
}

// MARK: - Actions

private extension AuthorizationViewController {
    
    @objc private func handlerNotification(_ notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        var keyboardHeight = 0.0
        if notification.name == UIResponder.keyboardWillShowNotification {
            let usedHeight = keyboardFrame.height + blockCredentials.frame.height/2
            let neededOffset = usedHeight - view.frame.height/2
            if
                usedHeight >= view.frame.height/2,
                neededOffset > 0
            {
                keyboardHeight = neededOffset
            }
        }
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.4 ) {
            self.blockCredentialsCenterYConstraint?.constant = -keyboardHeight
            self.view.layoutIfNeeded()
        }
    }
}



// MARK: - AuthorizationPresenterDelegate

extension AuthorizationViewController: AuthorizationPresenterDelegate {
    
}
