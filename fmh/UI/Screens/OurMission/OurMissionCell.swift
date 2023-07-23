//
//  OurMissionCell.swift
//  fmh
//
//  Created: 5/15/22
//

import UIKit

final class OurMissionCell: UICollectionViewCell {
    
    // MARK: - Private
    
    private var layoutCellExpanded: NSLayoutConstraint?
    private var layoutCellCollapsed: NSLayoutConstraint?
    
    // MARK: - UI
    
    private let taglineLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.numberOfLines = 0
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }()

    private lazy var arrowView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.image = UIImage(systemName: "chevron.down")
        view.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.54)
        return view
    }()

    private lazy var leafView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.image = UIImage(named: "icon.leaf")
        return view
    }()

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            animateCell(isHidden: !isSelected)
        }
    }
    
    // MARK: - Common init
    
    func commonInit() {
        clipsToBounds = true
        contentView.backgroundColor = .white
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 0.846, green: 0.846, blue: 0.846, alpha: 1).cgColor
        contentView.layer.cornerRadius = 8
        
        setupUI()
    }

    // MARK: - Setup UI

    private func setupUI() {

        contentView.addSubviews(leafView, arrowView, taglineLabel, descriptionLabel) {[
            leafView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            leafView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            leafView.widthAnchor.constraint(equalToConstant: 31),
            leafView.heightAnchor.constraint(equalToConstant: 28),

            arrowView.centerYAnchor.constraint(equalTo: leafView.centerYAnchor),
            arrowView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -17),

            taglineLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            taglineLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            taglineLabel.topAnchor.constraint(equalTo: leafView.bottomAnchor, constant: 8),

            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            descriptionLabel.topAnchor.constraint(equalTo: taglineLabel.bottomAnchor, constant: 8),

        ]}
        layoutCellExpanded = descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        layoutCellExpanded?.isActive = false

        layoutCellCollapsed = taglineLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        layoutCellCollapsed?.isActive = true

    }
    
    // MARK: - Animation Chevron

    private func animateCell(isHidden: Bool) {
        let upDown = CGAffineTransform(rotationAngle: .pi * -0.999)
        UIView.animate(withDuration: 0.3) {
            self.layoutCellCollapsed?.isActive = isHidden ? true : false
            self.layoutCellExpanded?.isActive = isHidden ? false : true
            self.invalidateIntrinsicContentSize()
            self.superview?.layoutIfNeeded()
            self.arrowView.transform = isHidden ? .identity : upDown
        }
    }
    
    // MARK: - Model
    
    struct Model {
        let title: String
        let descriptions: String
        let taglineColor: UIColor?
        
        init(title: String, descriptions: String, taglineColor: UIColor?) {
            self.title = title
            self.descriptions = descriptions
            self.taglineColor = taglineColor
        }
    }
}

extension OurMissionCell: DIFConfigurable {
    func configure(with model: Model) {
        taglineLabel.text = model.title
        descriptionLabel.text = model.descriptions
        taglineLabel.backgroundColor = model.taglineColor
    }
}
