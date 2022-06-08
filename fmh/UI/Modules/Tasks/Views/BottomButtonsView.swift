//
//  BottomButtonsView.swift
//  fmh
//
//  Created: 8.06.22
//

import UIKit

class BottomButtonsView: UIView {

    let backButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .default)
        let largeBoldDoc = UIImage(systemName: "chevron.backward", withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor =  #colorLiteral(red: 0.5141947269, green: 0.5141947269, blue: 0.5141947269, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let lookButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .default)
        let largeBoldDoc = UIImage(systemName: "eye", withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor =  #colorLiteral(red: 0.5141947269, green: 0.5141947269, blue: 0.5141947269, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let workButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .default)
        let largeBoldDoc = UIImage(systemName: "doc.badge.gearshape", withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor =  #colorLiteral(red: 0.5141947269, green: 0.5141947269, blue: 0.5141947269, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let editButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .default)
        let largeBoldDoc = UIImage(systemName: "square.and.pencil", withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor =  #colorLiteral(red: 0.5141947269, green: 0.5141947269, blue: 0.5141947269, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupConstraints()
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        let buttonsStack = UIStackView(views: [backButton,lookButton,workButton,editButton], axis: .horizontal, spacing: 50, alignment: .fill, distribution: .fillEqually)

        addSubview(buttonsStack)
        let constraints = [
            buttonsStack.topAnchor.constraint(equalTo: topAnchor),
            buttonsStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonsStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonsStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)

    }

}
