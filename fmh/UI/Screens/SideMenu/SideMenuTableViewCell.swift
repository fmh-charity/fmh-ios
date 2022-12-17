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

    var model: Model? {
        didSet {
            guard let model else { return }
//            self.imgView.image = model.img?.withRenderingMode(.alwaysTemplate)
            self.imgView.image = model.img?.withTintColor(.white, renderingMode: .alwaysTemplate)
            self.titleLabel.text = model.title
        }
    }
    
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
        let view = UIView()
        view.backgroundColor = .init(red: 1/255, green: 151/255, blue: 149/255, alpha: 1.0)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayouts() {
        self.selectedBackgroundView = selectedBackgroundViewCell
        
        contentView.addSubviews([imgView, titleLabel])
        NSLayoutConstraint.activate999([ // Приоритет нужен чтоб убрать предупреждения (особеность фраймворка)
            imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            imgView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imgView.widthAnchor.constraint(equalToConstant: 22),
            imgView.heightAnchor.constraint(equalToConstant: 22),

            titleLabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override func prepareForReuse() {
        imgView.image = nil
        titleLabel.text = nil
        selectionStyle = .default
    }
    
    struct Model {
        let img: UIImage?
        let title: String
    }
    
}

