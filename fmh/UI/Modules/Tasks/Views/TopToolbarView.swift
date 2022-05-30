//
//  TopToolbarView.swift
//  fmh
//
//  Created: 30.05.2022
//

import UIKit

class TopToolbarView: UIView {

    let taskLabel: UILabel = {
        let label = UILabel()
        label.text = "Заявки"
        label.font = UIFont(name: "Roboto", size: 19)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.5141947269, green: 0.5141947269, blue: 0.5141947269, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.5141947269, green: 0.5141947269, blue: 0.5141947269, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.5141947269, green: 0.5141947269, blue: 0.5141947269, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9118670225, green: 0.9118669629, blue: 0.9118669629, alpha: 1)
        setupConstraints()
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {

        addSubview(taskLabel)
        addSubview(addButton)
        addSubview(settingsButton)
        addSubview(infoButton)
        taskLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        taskLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        taskLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18).isActive = true

        addButton.topAnchor.constraint(equalTo: topAnchor, constant: 17).isActive = true
        addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17).isActive = true
        addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18).isActive = true

        settingsButton.topAnchor.constraint(equalTo: topAnchor, constant: 17).isActive = true
        settingsButton.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -30).isActive = true
        settingsButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18).isActive = true

        infoButton.topAnchor.constraint(equalTo: topAnchor, constant: 17).isActive = true
        infoButton.trailingAnchor.constraint(equalTo: settingsButton.leadingAnchor, constant: -30).isActive = true
        infoButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18).isActive = true
    }
}

