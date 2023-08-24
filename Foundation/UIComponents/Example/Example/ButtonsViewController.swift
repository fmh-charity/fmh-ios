//
//  ButtonsViewController.swift
//  Example
//
//  Created by Константин Туголуков on 22.08.2023.
//

import UIKit
import UIComponents

final class ButtonsViewController: UIViewController {
    
    // UI
    
    let stack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 16
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView())
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "UIComponents - стили кнопок"
        setupUI()
    }
    
    // MARK: Setup UI
    
    private func setupUI() {
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
        
        // MARK:
        stack.addArrangedSubview(Button(configuration: .default()))
        stack.addArrangedSubview(Button(configuration: .plain(.default)))
    }
}
