//
//  SideMenuTableViewCell.swift
//  fmh
//
//  Created: 11.12.2022
//

import Foundation
import UIKit


class SideMenuTableViewCell: UITableViewCell {
    
    class var identifier: String { return String(describing: self) }

    private lazy var imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var selectedBackgroundViewCell: UIView = {
        let selectionColorView = UIView()
        selectionColorView.backgroundColor = .init(red: 1/255, green: 151/255, blue: 149/255, alpha: 1.0)
        return selectionColorView
    }()
    
    override func prepareForReuse() {
        imgView.image = nil
        titleLabel.text = nil
        selectionStyle = .default
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: UIImage?, title: String) {
        self.selectedBackgroundView = selectedBackgroundViewCell
        self.imgView.image = image
        self.titleLabel.text = title
        
        if image != nil {
            addSubview(imgView)
            NSLayoutConstraint.activate([
                imgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
                imgView.centerYAnchor.constraint(equalTo: centerYAnchor),
                imgView.widthAnchor.constraint(equalToConstant: 22),
                imgView.heightAnchor.constraint(equalTo: imgView.widthAnchor)
            ])
        }
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: (image != nil) ? imgView.trailingAnchor : leadingAnchor, constant: 10)
        ])
    }
    
}

