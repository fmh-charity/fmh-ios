//
//  CreateTaskView.swift
//  fmh
//
//  Created: 02.06.2022
//

import UIKit

final class CreateTaskView: UIView {
    private let themeTextField = UITextField(placeholder: "Тема*")
    private let executorTextField = UITextField(placeholder: "Исполнитель*")
    private let dateTextField = UITextField(placeholder: "Дата*")
    private let timeTextField = UITextField(placeholder: "Время")
    private let descriptionTextField = UITextField(placeholder: "Описание")

   private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.layer.cornerRadius = 7
        button.backgroundColor = UIColor(named: "AccentColor")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor( UIColor.gray, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 7
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.lightGray.cgColor
        let dateAndTimeStack = UIStackView(views: [dateTextField, timeTextField], axis: .horizontal, spacing: 10, alignment: .fill, distribution: .fillEqually)
        let buttonsStack = UIStackView(views: [saveButton, cancelButton], axis: .vertical, spacing: 10, alignment: .fill, distribution: .fillEqually)
        let ownStack = UIStackView(views: [themeTextField, executorTextField, dateAndTimeStack, descriptionTextField], axis: .vertical, spacing: 30, alignment: .fill, distribution: .fillEqually)

        addSubview(buttonsStack)
        addSubview(ownStack)

        NSLayoutConstraint.activate([
            ownStack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            ownStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            ownStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            ownStack.bottomAnchor.constraint(equalTo: buttonsStack.topAnchor, constant: -30),

            buttonsStack.topAnchor.constraint(equalTo: ownStack.bottomAnchor, constant: 30),
            buttonsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            buttonsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            buttonsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            buttonsStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
        ])
    }
}
