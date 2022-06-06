//
//  PatientUICollectionViewCell.swift
//  fmh
//
//  Created: 05.06.2022
//

import UIKit

class PatientTableViewCell: UITableViewCell {
    static let identifier = "PatientTableViewCell"
    
    private let fioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray2
        label.font = UIFont(name: "SFNS Display", size: 13)
        return label
    }()
    
    private let fioDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "SF UI Display", size: 16)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func setUpConstraints() {
        
        contentView.addSubview(fioLabel)
        contentView.addSubview(fioDescriptionLabel)
        let offset: CGFloat = 5
    
        NSLayoutConstraint.activate([
            fioDescriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: offset),
            fioDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: offset),
            fioDescriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1 / 2),
            fioDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -offset)
        ])
        
        NSLayoutConstraint.activate([
            fioLabel.topAnchor.constraint(equalTo: fioDescriptionLabel.topAnchor),
            fioLabel.leadingAnchor.constraint(equalTo: fioDescriptionLabel.trailingAnchor),
            fioLabel.bottomAnchor.constraint(equalTo: fioDescriptionLabel.bottomAnchor),
            fioLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -offset)
        ])
    }
    
    func configure(descriptionTypes: DescriptionTypes, patientInfo: String) {
        fioDescriptionLabel.text = descriptionTypes.title
        fioLabel.text = patientInfo
    }
}

enum DescriptionTypes {
    case fio
    case dateOfBirth
    case status
    
    var title: String {
        switch self {
        case .fio:
            return "ФИО"
        case .dateOfBirth:
            return "Дата рождения"
        case .status:
            return "Статус"
        }
    }
}

