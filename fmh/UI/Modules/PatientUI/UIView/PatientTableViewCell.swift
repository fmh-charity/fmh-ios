//
//  PatientUICollectionViewCell.swift
//  fmh
//
//  Created: 05.06.2022
//

import UIKit

class PatientTableViewCell: UITableViewCell {
    static let identifier = "PatientTableViewCell"
    
    //MARK: - Properties
    
    private let trailingCell: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "SF UI Display", size: 16)
        return label
    }()
    
    private let leadingCell: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont(name: "SFNS Display", size: 13)
        return label
    }()
    
    //MARK: - Initializators

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setUpConstraints() {
        
        contentView.addSubview(trailingCell)
        contentView.addSubview(leadingCell)
        let offset: CGFloat = 7
    
        NSLayoutConstraint.activate([
            leadingCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: offset),
            leadingCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: offset),
            leadingCell.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1 / 2),
            leadingCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -offset)
        ])
        
        NSLayoutConstraint.activate([
            trailingCell.topAnchor.constraint(equalTo: leadingCell.topAnchor),
            trailingCell.bottomAnchor.constraint(equalTo: leadingCell.bottomAnchor),
            trailingCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -offset)
        ])
    }
    
    func configure(descriptionTypes: DescriptionTypes, patientInfo: String) {
        leadingCell.text = descriptionTypes.title
        trailingCell.text = patientInfo
    }
}

//MARK: - Enum

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

