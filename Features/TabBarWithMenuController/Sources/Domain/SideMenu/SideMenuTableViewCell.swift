//
//  SideMenuTableViewCell.swift
//  fmh
//
//  Created: 11.12.2022
//

import UIKit
import UIComponents

private enum Constant {
    static let backgroundColor = UIColor.systemBackground
    static let selectedBackgroundCellColor = UIColor(hex: "#01A5A3")
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
        $0.tintColor = Constant.tintColor
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private lazy var titleLabel: UILabel = {
        $0.textColor = Constant.textColor
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textAlignment = .left
        $0.numberOfLines = 1
        return $0
    }(UILabel())
    
    private lazy var selectedBackgroundViewCell: UIView = {
        $0.backgroundColor = Constant.selectedBackgroundCellColor
        $0.layer.cornerRadius = 6
        return $0
    }(UIView())
    
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
