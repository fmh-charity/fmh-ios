//
//  PatientsUIViewController.swift
//  fmh
//
//  Created: 25.05.2022
//

import UIKit

class PatientsUIView: UIView {
    
    let listLable: UILabel = {
        let label = UILabel()
        label.text = "Список пациентов"
        label.font = UIFont.systemFont(ofSize: 19)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let infoButton = UIButton(image: UIImage(systemName: "info.circle"))
    let sliderButton = UIButton(image: UIImage(systemName: "slider.horizontal.3"))
    let addButton = UIButton(image: UIImage(systemName: "plus.circle"))
    
    let stackViewButtons: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 29
        stack.alignment = .fill
        stack.backgroundColor = UIColor.systemGray5
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraints()
        self.backgroundColor = UIColor.systemGray5
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints() {
        addSubview(listLable)
        addSubview(stackViewButtons)
        stackViewButtons.addArrangedSubview(infoButton)
        stackViewButtons.addArrangedSubview(sliderButton)
        stackViewButtons.addArrangedSubview(addButton)
        
        let constraints = [
            
            listLable.topAnchor.constraint(equalTo: self.topAnchor, constant:  15),
            listLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            listLable.trailingAnchor.constraint(equalTo: stackViewButtons.leadingAnchor, constant: -45),
            listLable.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            
            stackViewButtons.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
            stackViewButtons.leadingAnchor.constraint(equalTo: listLable.trailingAnchor, constant: 49),
            stackViewButtons.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            stackViewButtons.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
        
        ]
        NSLayoutConstraint.activate(constraints)
    }
}


