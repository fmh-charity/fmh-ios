//
//  SideMenuTableViewCell.swift
//  fmh
//
//  Created: 11.12.2022
//

import UIKit

private enum Constant {
    static let backgroundColor = UIColor.systemBackground
    static let selectedBackgroundCellColor = UIColor.secondarySystemBackground
    static let textColor = UIColor(hex: "#535353")
    static let tintColor = UIColor(hex: "#535353")
    static let imgViewSize = 24.0
}

final class SideMenuTableViewCell: UITableViewCell {
    
    class var identifier: String { return String(describing: self) }
    
    // MARK: - Configure model
    
    var model: Model? {
        didSet {
            guard let model else { return }
            self.imgView.image = model.img?.withTintColor(.white, renderingMode: .alwaysTemplate)
            self.titleLabel.text = model.title
        }
    }
    
    // MARK: - UI
    
    private lazy var imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = Constant.tintColor
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constant.textColor
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var selectedBackgroundViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = Constant.selectedBackgroundCellColor
        view.layer.cornerRadius = 6
        return view
    }()
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Common init
    
    private func commonInit() {
        backgroundColor = Constant.backgroundColor
        selectedBackgroundView = selectedBackgroundViewCell
        setupUI()
    }
    
    // MARK: - Setup UI
    
    func setupUI() {
        contentView.addSubviews(imgView, titleLabel) {[
            imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imgView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imgView.widthAnchor.constraint(equalToConstant: Constant.imgViewSize),
            imgView.heightAnchor.constraint(equalToConstant: Constant.imgViewSize),
            
            titleLabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]}
    }
    
    override func prepareForReuse() {
        imgView.image = nil
        titleLabel.text = nil
        selectionStyle = .default
    }
    
    // MARK: - Model
    
    struct Model {
        let img: UIImage?
        let title: String
    }
}
