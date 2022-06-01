//
//  CommentTableCell.swift
//  fmh
//
//  Created: 26.05.22
//

import UIKit

class CommentTableCell: UITableViewCell {

    
    static let reuseId = "CommentTableCell"
    let commentNumLabel = UILabel(text: "Комментарий 1",
                                  font: UIFont(name: "SF UI Display", size: 15),
                                  tintColor: .black,
                                  textAlignment: .center)
    let fioLabel = UILabel(text: "В.В.Виталий",
                           font: UIFont(name: "SFNS Display", size: 13),
                           tintColor: #colorLiteral(red: 0.3411764706, green: 0.3411764706, blue: 0.3411764706, alpha: 1),
                           textAlignment: .center)
    let dateLabel = UILabel(text: "24.05.2022",
                            font: UIFont(name: "Roboto", size: 15),
                            tintColor: #colorLiteral(red: 0.3411764706, green: 0.3411764706, blue: 0.3411764706, alpha: 1),
                            textAlignment: .right)
    let timeLabel = UILabel(text: "17:00",
                            font: UIFont(name: "Roboto", size: 12),
                            tintColor: #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 1),
                            textAlignment: .left)

    let bottomSeparator: UILabel = {
        let separator = UILabel()
        separator.layer.borderColor = #colorLiteral(red: 0.8537765145, green: 0.8537764549, blue: 0.8537764549, alpha: 1)
        separator.layer.borderWidth = 1
        separator.layer.backgroundColor = UIColor.gray.cgColor
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()

    let editCommentButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraint() {
        commentNumLabel.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        let topStackView = UIStackView(views: [commentNumLabel, editCommentButton],
                                       axis: .horizontal, spacing: 5,
                                       alignment: .fill,
                                       distribution: .equalSpacing)
        let dateStackView = UIStackView(views: [dateLabel, timeLabel],
                                        axis: .horizontal,
                                        spacing: 0,
                                        alignment: .fill,
                                        distribution: .fillEqually)
        addSubview(bottomSeparator)
        addSubview(topStackView)
        addSubview(dateStackView)
        addSubview(fioLabel)
        fioLabel.textAlignment = .left
        timeLabel.textAlignment = .center
        editCommentButton.contentVerticalAlignment = .fill
        editCommentButton.contentHorizontalAlignment = .fill
        let constraints = [
            editCommentButton.widthAnchor.constraint(equalToConstant: 22),
            editCommentButton.heightAnchor.constraint(equalToConstant: 22),
            topStackView.topAnchor.constraint(equalTo: topAnchor,
                                              constant: 7),
            topStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                  constant: 10),
            topStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                   constant: -10),
            topStackView.bottomAnchor.constraint(equalTo: fioLabel.topAnchor,
                                                 constant: -28),
            fioLabel.topAnchor.constraint(equalTo: topStackView.bottomAnchor,
                                          constant: 32),
            fioLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                              constant: 10),
            fioLabel.trailingAnchor.constraint(equalTo: dateStackView.leadingAnchor,
                                               constant: -52),
            fioLabel.bottomAnchor.constraint(equalTo: bottomSeparator.topAnchor,
                                             constant: -4),
            dateStackView.leadingAnchor.constraint(equalTo: fioLabel.trailingAnchor,
                                                   constant: 52),
            dateStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                    constant: -4),
            dateStackView.centerYAnchor.constraint(equalTo: fioLabel.centerYAnchor),
            bottomSeparator.topAnchor.constraint(equalTo: fioLabel.bottomAnchor, constant: 4),
            bottomSeparator.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomSeparator.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomSeparator.heightAnchor.constraint(equalToConstant: 1),
            bottomSeparator.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.95)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

