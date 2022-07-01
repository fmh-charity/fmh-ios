//
//  HeaderMenuView.swift
//  fmh
//
//  Created: 10.06.2022
//

import UIKit

class HeaderMenuView: UIView {
    
    // MARK: - Private properties
    
    private lazy var menuNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.font = UIFont(name: "SF UI Display", size: 19)
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var leftButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.tintColor = .gray
        button.contentMode = .scaleAspectFit
        return button
    }()

    private lazy var rightButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.tintColor = .gray
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var stackButtonView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftButton, rightButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.axis = .horizontal
        stackView.spacing = -100
        stackView.backgroundColor = .systemGray5
        return stackView
    }()
    
    // MARK: - Initializers
    
    convenience init(labelText: String, leftButtonImage: UIImage?, rightButtonImage: UIImage?) {
        self.init()
        self.backgroundColor = .systemGray5
        self.translatesAutoresizingMaskIntoConstraints = false
        setupConstrains()
        menuNameLabel.text = labelText
        leftButton.setImage(leftButtonImage, for: .normal)
        rightButton.setImage(rightButtonImage, for: .normal)
    }
    
}

// MARK: - Setup constraints

extension HeaderMenuView {
    
    private func setupConstrains() {
        
        NSLayoutConstraint.activate([
            menuNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            menuNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            menuNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            stackButtonView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            stackButtonView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackButtonView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5)
        ])
        
    }
    
}
