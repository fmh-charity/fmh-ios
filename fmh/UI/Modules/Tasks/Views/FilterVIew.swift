//
//  FilterVIew.swift
//  fmh
//
//  Created: 08.06.2022
//

import UIKit

class FilterVIew: UIView {

    private let mainLabel = UILabel(text: "Фильтровать",
                                    font: UIFont.systemFont(ofSize: 15),
                                    tintColor: UIColor(named: "AccentColor") ?? .black,
                                    textAlignment: .left)

    private let isOpenLabel = UILabel(text: "Открыта",
                                      font: UIFont.systemFont(ofSize: 13),
                                      tintColor: .black,
                                      textAlignment: .left)

    private let inWorkLabel = UILabel(text: "В работе",
                                      font: UIFont.systemFont(ofSize: 13),
                                      tintColor: .black,
                                      textAlignment: .left)

    private let isCompletedLabel = UILabel(text: "Выполнена",
                                           font: UIFont.systemFont(ofSize: 13),
                                           tintColor: .black,
                                           textAlignment: .left)

    private let isCanceledLabel = UILabel(text: "Отменена",
                                          font: UIFont.systemFont(ofSize: 13),
                                          tintColor: .black,
                                          textAlignment: .left)

    private let isOpenCheckButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let inWorkCheckButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let isCompletedCheckButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let isCanceledCheckButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupElements() {
        addSubview(mainLabel)
        let labelStackView = UIStackView(views: [isOpenLabel, inWorkLabel, isCompletedLabel, isCanceledLabel], axis: .vertical, spacing: 15, alignment: .fill, distribution: .fillEqually)
        let buttonsStackView = UIStackView(views: [isOpenCheckButton, inWorkCheckButton, isCanceledCheckButton, isCanceledCheckButton], axis: .vertical, spacing: 15, alignment: .fill, distribution: .fillEqually)
        let ownStack = UIStackView(views: [labelStackView, buttonsStackView], axis: .vertical, spacing: 15, alignment: .fill, distribution: .fillEqually)
        addSubview(ownStack)

        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            mainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainLabel.bottomAnchor.constraint(equalTo: ownStack.topAnchor, constant: -50),

            ownStack.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 50),
            ownStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            ownStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            ownStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100)
        ])
    }
}
