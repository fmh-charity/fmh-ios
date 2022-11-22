//
//  NewsListCollectionViewCell.swift
//  fmh
//
//  Created: 14.06.2022
//

import UIKit

class NewsListCollectionViewCell: UICollectionViewCell {

    typealias Model = News
    
    private var collapsedConstraint: NSLayoutConstraint!
    private var expandedConstraint: NSLayoutConstraint!
    
    /// Top Elements
    private lazy var topContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let subTopView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var arrowUpDown: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var imageCategory: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    /// Main Elements
    private lazy var mainContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    /// Bottom Elements
    private lazy var bottomContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.backgroundColor = .systemGray6
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        clipsToBounds = true

        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.5
        
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayouts() {
        
        let padding: CGFloat = 8
        
        /// Add Content views
        contentView.addSubview(topContentView)
        NSLayoutConstraint.activate([
            topContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topContentView.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
        contentView.addSubview(mainContentView)
        NSLayoutConstraint.activate([
            mainContentView.topAnchor.constraint(equalTo: topContentView.bottomAnchor, constant: padding),
            mainContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        contentView.addSubview(bottomContentView)
        NSLayoutConstraint.activate([
            bottomContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomContentView.heightAnchor.constraint(equalToConstant: 20)
        ])
 
        /// Collapsed mode Cell
        collapsedConstraint = bottomContentView.topAnchor.constraint(equalTo: topContentView.bottomAnchor)
        collapsedConstraint.priority = .defaultLow
        collapsedConstraint.isActive = true
        /// Expanded mode Cell
        expandedConstraint = bottomContentView.topAnchor.constraint(equalTo: mainContentView.bottomAnchor)
        expandedConstraint.priority = .defaultLow
        
        /// Add elements in topContentView
        topContentView.addSubview(subTopView)
        NSLayoutConstraint.activate([
            subTopView.topAnchor.constraint(equalTo: topContentView.topAnchor, constant: padding),
            subTopView.leadingAnchor.constraint(equalTo: topContentView.leadingAnchor, constant: padding),
            subTopView.trailingAnchor.constraint(equalTo: topContentView.trailingAnchor, constant: -padding),
            subTopView.heightAnchor.constraint(equalToConstant: 40),
        ])

        subTopView.addSubview(imageCategory)
        NSLayoutConstraint.activate([
            imageCategory.leadingAnchor.constraint(equalTo: subTopView.leadingAnchor),
            imageCategory.centerYAnchor.constraint(equalTo: subTopView.centerYAnchor),
            imageCategory.heightAnchor.constraint(equalToConstant: 25),
            imageCategory.widthAnchor.constraint(equalTo: imageCategory.heightAnchor)
        ])

        subTopView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: subTopView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageCategory.trailingAnchor, constant: padding),
            titleLabel.bottomAnchor.constraint(equalTo: subTopView.bottomAnchor)
        ])

        subTopView.addSubview(arrowUpDown)
        NSLayoutConstraint.activate([
            arrowUpDown.topAnchor.constraint(equalTo: subTopView.topAnchor),
            arrowUpDown.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: padding),
            arrowUpDown.bottomAnchor.constraint(equalTo: subTopView.bottomAnchor),
            arrowUpDown.trailingAnchor.constraint(equalTo: subTopView.trailingAnchor)
        ])

        
        /// Add elements in  mainContentView
        mainContentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor, constant: -padding),
            descriptionLabel.bottomAnchor.constraint(equalTo: mainContentView.bottomAnchor, constant: -padding),
        ])
        
        
        /// Add elements in  bottomContentView
        bottomContentView.addSubview(categoryLabel)
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: bottomContentView.topAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: bottomContentView.leadingAnchor, constant: padding),
            categoryLabel.bottomAnchor.constraint(equalTo: bottomContentView.bottomAnchor),
            categoryLabel.centerYAnchor.constraint(equalTo: bottomContentView.centerYAnchor)
        ])
        
        bottomContentView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: bottomContentView.topAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: bottomContentView.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: bottomContentView.bottomAnchor),
            dateLabel.widthAnchor.constraint(equalTo: bottomContentView.widthAnchor, multiplier: 1/2.5)
        ])

    }

    override var isSelected: Bool {
        didSet{
            collapsedConstraint.isActive = !isSelected
            expandedConstraint.isActive = isSelected
            
            UIView.animate(withDuration: 0.3) { [self] in
                let upDown = CGAffineTransform(rotationAngle: .pi * -0.999)
                self.arrowUpDown.transform = self.isSelected ? upDown : .identity
                self.categoryLabel.alpha = self.isSelected ? 1 : 0
            }
        }
    }
    
    override func prepareForReuse() {

    }
    
    func configure(model: Model, id: String) {
        self.imageCategory.image = model.categoryImg
        self.titleLabel.text = id + ":\n" + model.title
        
        self.descriptionLabel.text = model.description
        self.categoryLabel.text = model.categoryName
        self.dateLabel.text = model.publishDate.toString("dd.MM.yyyy")
    }

}

// MARK: - preferredLayoutAttributesFitting
//extension NewsMainCollectionViewCell {
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        super.preferredLayoutAttributesFitting(layoutAttributes)
//        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
//        return layoutAttributes
//    }
//}
