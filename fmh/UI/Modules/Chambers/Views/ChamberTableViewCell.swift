//
//  ChamberTableViewCell.swift
//  fmh
//
//  Created: 14.06.2022
//

import UIKit

enum DecriptionChamber {
    case numberOfChamber
    case post
    case block
    case freePlaces
    case comment
    
    var title: String {
        switch self {
        case .numberOfChamber:
            return "№ палаты"
        case .post:
            return "Пост"
        case .block:
            return "Блок"
        case .freePlaces:
            return "Свободных мест"
        case .comment:
            return "Комментарий"
        }
    }
}

class ChamberTableViewCell: UITableViewCell {
    
    static let identifier = "ChamberTableViewCell"
    
    private lazy var leadingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont(name: "SFNS Display", size: 13)
        return label
    }()
    
    private lazy var trailingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont(name: "SF UI Display", size: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstaints() {
        
        contentView.addSubview(leadingLabel)
        contentView.addSubview(trailingLabel)
        
        NSLayoutConstraint.activate([
            leadingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            leadingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            leadingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
            leadingLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            trailingLabel.topAnchor.constraint(equalTo: leadingLabel.topAnchor),
            trailingLabel.bottomAnchor.constraint(equalTo: leadingLabel.bottomAnchor),
            trailingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            trailingLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingLabel.trailingAnchor)
        ])
    }
    
    func configure(with description: DecriptionChamber, and chamberInfo: String) {
        leadingLabel.text = description.title
        trailingLabel.text = chamberInfo
    }
    
}
