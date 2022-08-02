//
//  AddCommentTableViewCell.swift
//  fmh
//
//  Created: 30.05.2022
//

import UIKit

final class AddCommentTableViewCell: UITableViewCell {
    static let reuseId = "AddCommentTableViewCell"

    private let addCommentLabel: UILabel = {
        let label = UILabel()
        label.text = "Добавить комментарий"
        label.font = UIFont(name: "SFNS Display", size: 13)
        label.textColor = #colorLiteral(red: 0.3411764706, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.3411764706, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        addSubview(addCommentLabel)
        addSubview(plusButton)
        plusButton.contentVerticalAlignment = .fill
        plusButton.contentHorizontalAlignment = .fill
        let constraints = [
            addCommentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            addCommentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            addCommentLabel.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -65),
            addCommentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),

            plusButton.centerYAnchor.constraint(equalTo: addCommentLabel.centerYAnchor),
            plusButton.leadingAnchor.constraint(equalTo: addCommentLabel.trailingAnchor, constant: 65),
            plusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            plusButton.widthAnchor.constraint(equalToConstant: 21),
            plusButton.heightAnchor.constraint(equalToConstant: 21)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
