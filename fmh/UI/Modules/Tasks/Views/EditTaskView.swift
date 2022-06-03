//
//  EditTaskView.swift
//  fmh
//
//  Created: 03.06.2022
//

import UIKit

final class EditTaskView: UIView {
    private var themeTextField = UITextField(placeholder: "Тема*")
    var executorTextField = UITextField(placeholder: "Исполнитель*")
    private var dateTextField = UITextField(placeholder: "Дата*")
    private var timeTextField = UITextField(placeholder: "Время")
    private var descriptionTextField = UITextField(placeholder: "Описание")

    private let themeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "тема"
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "описание"
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "дата"
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "время"
        label.textAlignment = .left
        label.backgroundColor = .white
        return label
    }()

    private var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.layer.cornerRadius = 7
        button.backgroundColor = UIColor(named: "AccentColor")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var cancelButton: UIButton = {
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

        let dateAndTimeStack = UIStackView(views: [dateTextField, timeTextField], axis: .horizontal, spacing: 10, alignment: .fill, distribution: .fillEqually)
        let buttonsStack = UIStackView(views: [saveButton, cancelButton], axis: .vertical, spacing: 10, alignment: .fill, distribution: .fillEqually)
        let ownStack = UIStackView(views: [themeTextField, executorTextField, dateAndTimeStack, descriptionTextField], axis: .vertical, spacing: 30, alignment: .fill, distribution: .fillEqually)

        addSubview(buttonsStack)
        addSubview(ownStack)

        addSubview(themeLabel)
        addSubview(descriptionLabel)
        addSubview(dateLabel)
        addSubview(timeLabel)

        NSLayoutConstraint.activate([
            ownStack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            ownStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            ownStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            ownStack.bottomAnchor.constraint(equalTo: buttonsStack.topAnchor, constant: -30),

            buttonsStack.topAnchor.constraint(equalTo: ownStack.bottomAnchor, constant: 30),
            buttonsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            buttonsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            buttonsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            buttonsStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),

            themeLabel.topAnchor.constraint(equalTo: themeTextField.topAnchor, constant: -7),
            themeLabel.leadingAnchor.constraint(equalTo: themeTextField.leadingAnchor, constant: 10),
            themeLabel.widthAnchor.constraint(equalToConstant: 50),
            themeLabel.heightAnchor.constraint(equalToConstant: 15),

            descriptionLabel.topAnchor.constraint(equalTo: descriptionTextField.topAnchor, constant: -7),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionTextField.leadingAnchor, constant: 10),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 75),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 15),

            dateLabel.topAnchor.constraint(equalTo: dateTextField.topAnchor, constant: -7),
            dateLabel.leadingAnchor.constraint(equalTo: dateTextField.leadingAnchor, constant: 10),
            dateLabel.widthAnchor.constraint(equalToConstant: 50),
            dateLabel.heightAnchor.constraint(equalToConstant: 15),

            timeLabel.topAnchor.constraint(equalTo: timeTextField.topAnchor, constant: -7),
            timeLabel.leadingAnchor.constraint(equalTo: timeTextField.leadingAnchor, constant: 10),
            timeLabel.widthAnchor.constraint(equalToConstant: 50),
            timeLabel.heightAnchor.constraint(equalToConstant: 15),
        ])

        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}

