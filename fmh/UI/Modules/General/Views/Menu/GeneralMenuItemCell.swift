//
//  GeneralMenuItemCell.swift
//  fmh
//
//  Created: 18.05.2022
//

import UIKit

class GeneralMenuItemCell: UITableViewCell {
    
    class var identifier: String { return String(describing: self) }
    
    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 1
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var selectedBackgroundViewCell: UIView = {
        let selectionColorView = UIView()
        selectionColorView.backgroundColor = .init(red: 1/255, green: 151/255, blue: 149/255, alpha: 1.0)
        
        return selectionColorView
    }()
    
    override func prepareForReuse() {
        iconImageView.image = nil
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
        
        self.iconImageView.image = image
        self.titleLabel.text = title
        
        if image != nil {
            addSubview(iconImageView)
            NSLayoutConstraint.activate([
                iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
                iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                iconImageView.widthAnchor.constraint(equalToConstant: 22),
                iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor)
            ])
        }
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.leadingAnchor.constraint(
                equalTo: (image != nil) ? iconImageView.trailingAnchor : leadingAnchor,
                constant: 10)
        ])
    }
    
}
