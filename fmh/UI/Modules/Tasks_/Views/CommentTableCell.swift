//
//  CommentTableCell.swift
//  fmh
//
//  Created: 26.05.22
//

import UIKit

class CommentTableCell: UITableViewCell {
    static let reuseId = "CommentTableCell"
    let commentNumLabel = UILabel(text: "Комментарий 1", font: UIFont(name: "SF UI Display", size: 15), tintColor: .black, textAlignment: .center)
    let fioLabel = UILabel(text: "В.В.Виталий", font: UIFont(name: "SFNS Display", size: 13), tintColor: .black, textAlignment: .center)
    let dateLabel = UILabel(text: "24.05.2022", font: UIFont(name: "Roboto", size: 15) , tintColor: .black, textAlignment: .right)
    let timeLabel = UILabel(text: "17:00", font: UIFont(name: "Roboto", size: 12) , tintColor: UIColor(named: "TaskCollectionTextColor") ?? .black, textAlignment: .left)
    let editCommentButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
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
        let topStackView = UIStackView(views: [commentNumLabel,editCommentButton], axis: .horizontal, spacing: 5, alignment: .fill, distribution: .fillEqually)
        addSubview(topStackView)
        addSubview(fioLabel)
        addSubview(dateLabel)
        addSubview(timeLabel)
        let constraints = [
            topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 13),
            topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2),
            topStackView.bottomAnchor.constraint(equalTo: fioLabel.topAnchor, constant: -5),
            fioLabel.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 5),
            fioLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            fioLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -50),
            fioLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
            fioLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            dateLabel.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: fioLabel.trailingAnchor, constant: 50),
            dateLabel.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: -5),
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
            timeLabel.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 5),
            timeLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 5),
            timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
