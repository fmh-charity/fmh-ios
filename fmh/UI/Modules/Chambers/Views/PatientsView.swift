//
//  PatientsView.swift
//  fmh
//
//  Created: 18.07.2022
//

import UIKit

class PatientsView: UIView {
    
    // MARK: - Private properties
    
    private lazy var patientsOfChamberLabel: UILabel = {
        let label = UILabel(textColor: .gray, font: UIFont(name: "SFNS Display", size: 13), numberOfLines: 1)
        addSubview(label)
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        button.backgroundColor = .clear
        button.tintColor = .gray
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
//        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        return button
    }()
    
    private lazy var patientLabel: UILabel = {
        let label = UILabel(textColor: .black, font: UIFont(name: "SF UI Display", size: 16))
        addSubview(label)
        return label
    }()
    
    // MARK: - Initializers
    
    convenience init(labelText: String, patientText: String, plusButtonImage: UIImage?) {
        self.init()
        backgroundColor = .white
        layer.borderWidth = 0.5
        layer.borderColor = CGColor(gray: 0.75, alpha: 1)
        translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
        patientsOfChamberLabel.text = labelText
        patientLabel.text = patientText
        plusButton.setImage(plusButtonImage, for: .normal)
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = .white
//        layer.borderWidth = 0.5
//        layer.borderColor = CGColor(gray: 0.75, alpha: 1)
//        translatesAutoresizingMaskIntoConstraints = false
//        setupConstraints()
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    // MARK: - Private methods
    
    @objc private func plusButtonTapped() {
        print(#function)
    }
    
}

// MARK: - Setup constraints

extension PatientsView {
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            patientsOfChamberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            patientsOfChamberLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            patientsOfChamberLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            plusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            plusButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            plusButton.bottomAnchor.constraint(equalTo: patientsOfChamberLabel.bottomAnchor),
            plusButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1)
        ])
        
        NSLayoutConstraint.activate([
            patientLabel.leadingAnchor.constraint(equalTo: patientsOfChamberLabel.leadingAnchor),
            patientLabel.topAnchor.constraint(equalTo: patientsOfChamberLabel.bottomAnchor, constant: 7.5),
            patientLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7.5),
            patientLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5)
        ])
        
    }
    
}
