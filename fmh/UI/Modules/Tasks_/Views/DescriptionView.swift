//
//  DescriptionView.swift
//  fmh
//
//  Created: 26.05.22
//

import UIKit

class DescriptionView: UIView {
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: "BackgroundTaskCell")
        label.font = UIFont(name: "SF UI Display", size: 15)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(named: "BackgroundTaskCell")
        addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
