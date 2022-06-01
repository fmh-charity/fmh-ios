//
//  ExampleCell.swift
//  fmh
//
//  Created: 30.05.2022
//

import UIKit

class ExampleCell: UICollectionViewCell {
    
    struct Model {
        let titleLabel: String
        let descriptionLabel: String
    }
    
    private var collapsedConstraint: NSLayoutConstraint!
    private var expandedConstraint: NSLayoutConstraint!
    
    private var topContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var mainContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 1
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .brown
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func prepareForReuse() {

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        
        backgroundColor = .systemBackground
        
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayouts() {
        
        contentView.addSubview(topContentView)
        NSLayoutConstraint.activate([
            topContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topContentView.heightAnchor.constraint(equalToConstant: 30.0)
        ])
        /// Collapsed Cell
        collapsedConstraint = contentView.bottomAnchor.constraint(equalTo: topContentView.bottomAnchor)
        collapsedConstraint.priority = .defaultLow
        collapsedConstraint.isActive = true
        
        topContentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topContentView.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: topContentView.leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: topContentView.trailingAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: topContentView.bottomAnchor, constant: 0)
        ])
        
        contentView.addSubview(mainContentView)
        NSLayoutConstraint.activate([
            mainContentView.topAnchor.constraint(equalTo: topContentView.bottomAnchor, constant: 0),
            mainContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        /// Expanded Cell
        expandedConstraint = contentView.bottomAnchor.constraint(equalTo: mainContentView.bottomAnchor)
        expandedConstraint.priority = .defaultLow
        
        mainContentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: mainContentView.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: mainContentView.bottomAnchor),
        ])

    }

    override var isSelected: Bool {
        didSet{
            collapsedConstraint.isActive = !isSelected
            expandedConstraint.isActive = isSelected
        }
    }
    
    func configure(model: Model) {
        self.titleLabel.text = model.titleLabel
        self.descriptionLabel.text = model.descriptionLabel
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
    
}
