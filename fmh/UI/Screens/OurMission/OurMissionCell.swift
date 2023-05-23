//
//  OurMissionCell.swift
//  fmh
//
//  Created: 5/15/22
//

import UIKit

final class OurMissionCellDIFModel: DIFCollectionViewCellModel<OurMissionCell_> {
    let title: String
    let descriptions: String
    
    init(collectionView: UICollectionView, taglineLabel: String, descriptions: String) {
        self.title = taglineLabel
        self.descriptions = descriptions
        super.init(collectionView, id: taglineLabel)
    }
}

final class OurMissionCell_: DIFCollectionViewCell {
    
    // MARK: - Set data
    
    override var model: DIFItem? {
        didSet {
            guard let model = model as? OurMissionCellDIFModel else {
                return
            }
            
            titleLabel.text = model.title
            descriptionLabel.text = model.descriptions
        }
    }
    
    // MARK: - Private
    
    private var layoutCellExpanded: NSLayoutConstraint?
    private var layoutCellCollapsed: NSLayoutConstraint?
    private var layoutCellHeight: NSLayoutConstraint?
    
    // MARK: - UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    // MARK: - Common init
    
    override func commonInit() {
        super.commonInit()
        
        clipsToBounds = true
        
        contentView.addSubviews(titleLabel, descriptionLabel) {[
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ]}
        
//        layoutCellHeight = contentView.heightAnchor.constraint(equalToConstant: 50)
//        layoutCellHeight?.isActive = true
        
        layoutCellExpanded = contentView.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor)
        layoutCellExpanded?.isActive = true
        
        layoutCellCollapsed = contentView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        layoutCellCollapsed?.isActive = false
    }
    
    // MARK: -
    
    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.4) {
                self.layoutCellCollapsed?.isActive = self.isSelected ? true : false
                self.layoutCellExpanded?.isActive = self.isSelected ? false : true
                self.invalidateIntrinsicContentSize()
                self.superview?.layoutIfNeeded()
                
            }

        }
    }
}

final class OurMissionCellDIFModel2: DIFCollectionViewCellModel<OurMissionCell_2> {
    let taglineLabel: String
    
    init(collectionView: UICollectionView, taglineLabel: String) {
        self.taglineLabel = taglineLabel
        super.init(collectionView, id: taglineLabel)
    }
}

final class OurMissionCell_2: DIFCollectionViewCell {
    
    // MARK: - Set data
    
    override var model: DIFItem? {
        didSet {
            guard let model = model as? OurMissionCellDIFModel2 else {
                return
            }
            
            taglineLabel.text = model.taglineLabel
        }
    }
    
    // MARK: - UI
    
    private let taglineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .blue
        return label
    }()
    
    // MARK: - Common init
    
    override func commonInit() {
        super.commonInit()
        
        contentView.addSubviews(taglineLabel) {[
            taglineLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            taglineLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            taglineLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            taglineLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]}
    }
    
}

class OurMissionCell: UITableViewCell {

    class var identifier: String { return String(describing: self) }
    
    // MARK: - UI
    
    private let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.846, green: 0.846, blue: 0.846, alpha: 1).cgColor
        return view
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 9
        return view
    }()
    
    private let taglineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let taglineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let arrowView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.image = UIImage(systemName: "chevron.down")
        view.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.54)
        return view
    }()
    
    private let leafView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.image = UIImage(named: "icon.leaf")
        return view
    }()
    
    var isDescriptionHidden = true {
        willSet {
            animateCell(isHidden: newValue)
        }
    }
    
    // MARK: - Configure
    
    override func prepareForReuse() {
        super.prepareForReuse()
        taglineView.backgroundColor = nil
        taglineLabel.text = nil
        taglineLabel.backgroundColor = nil
        descriptionLabel.text = nil
    }
    
    func configure(cellData: OurMissionStruct?) {
        guard let cellData = cellData else { return }
        taglineView.backgroundColor = cellData.color
        taglineLabel.text = cellData.tagline
        taglineLabel.backgroundColor = cellData.color
        descriptionLabel.text = cellData.more
        isDescriptionHidden = cellData.isHidden
        setupUI()
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        
        self.addSubview(cellView)
        cellView.addSubview(leafView)
        cellView.addSubview(arrowView)
        cellView.addSubview(stackView)
        
        stackView.addArrangedSubview(taglineView)
        taglineView.addSubview(taglineLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            leafView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10),
            leafView.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 10),
            leafView.widthAnchor.constraint(equalToConstant: 31),
            leafView.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        NSLayoutConstraint.activate([
            arrowView.centerYAnchor.constraint(equalTo: leafView.centerYAnchor),
            arrowView.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -17)
        ])
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            stackView.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 9),
            stackView.topAnchor.constraint(equalTo: leafView.bottomAnchor, constant: 5),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: cellView.bottomAnchor, constant: -9)
        ])
        
        NSLayoutConstraint.activate([
            taglineLabel.centerYAnchor.constraint(equalTo: taglineView.centerYAnchor),
            taglineLabel.centerXAnchor.constraint(equalTo: taglineView.centerXAnchor),
            taglineLabel.leftAnchor.constraint(equalTo: taglineView.leftAnchor, constant: 8),
            taglineLabel.topAnchor.constraint(equalTo: taglineView.topAnchor, constant: 6)
        ])
    }

    // MARK: - Actions
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func animateCell(isHidden: Bool) {
        let upDown = CGAffineTransform(rotationAngle: .pi * -0.999)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.descriptionLabel.isHidden = isHidden ? true : false
            self?.arrowView.transform = isHidden ? .identity : upDown
        } completion: { [weak self] _ in
            self?.descriptionLabel.alpha = isHidden ? 0 : 1
        }
    }
}
