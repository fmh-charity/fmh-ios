//
//  NewsCollectionViewCell.swift
//  fmh
//
//  Created: 19.05.2022
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    //MARK: - Переопределяем isSelected чтоб вызывался updateAppearance после каждого выделения ячейки
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCell()
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - констрейнт для сжатого состояния
    private var collapsedConstraint: NSLayoutConstraint!
    
    //MARK: - констрейнт для расширенного состояния
    private var expandedConstraint: NSLayoutConstraint!
    
    private lazy var mainContainer = UIView()
    private lazy var topContainer = UIView()
    private lazy var middleContainer = UIView()
    private lazy var bottomContainer = UIView()

    private lazy var arrowUpDown: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: NewsConstants.Images.chevronDown)?.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = NewsConstants.Collor.chevron
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var imageCategory: UIImageView = {
        let imageView = UIImageView()
        //imageView.backgroundColor = .magenta
        return imageView
    }()
    
    var labelTitle: UILabel = {
        let label = UILabel()
        label.text = "Новостной заголовок"
        label.numberOfLines = 2
        label.font = NewsConstants.Font.titleNews
        return label
    }()
    
    var labelDescription: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = NewsConstants.Font.descriptionNews
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()
  
    var labelCategory: UILabel = {
        let label = UILabel()
        label.font = NewsConstants.Font.holderTitle
        label.textColor = NewsConstants.Collor.holderText
        label.alpha = 0
        label.text = "Праздник"
        return label
    }()
    
    var labelDate: UILabel = {
        let label = UILabel()
        label.font = NewsConstants.Font.holder
        label.textColor = NewsConstants.Collor.holderText
        label.backgroundColor = NewsConstants.Collor.fillRectangel
        label.text = "22.12.2022"
        return label
    }()
    
    func configureCell() {
        mainContainer.clipsToBounds = true
        topContainer.backgroundColor = .white
        middleContainer.backgroundColor = .white
        bottomContainer.backgroundColor = .white
        
        makeConstraint()
        updateAppearance()
        borderForCell()
    }
    
    func makeConstraint() {
        contentView.addSubview(mainContainer)
        mainContainer.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        mainContainer.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mainContainer.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        mainContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        mainContainer.addSubview(topContainer)
        topContainer.translatesAutoresizingMaskIntoConstraints = false
        topContainer.leftAnchor.constraint(equalTo: mainContainer.leftAnchor).isActive = true
        topContainer.topAnchor.constraint(equalTo: mainContainer.topAnchor).isActive = true
        topContainer.rightAnchor.constraint(equalTo: mainContainer.rightAnchor).isActive = true
        topContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        mainContainer.addSubview(middleContainer)
        middleContainer.translatesAutoresizingMaskIntoConstraints = false
        middleContainer.leftAnchor.constraint(equalTo: mainContainer.leftAnchor).isActive = true
        middleContainer.rightAnchor.constraint(equalTo: mainContainer.rightAnchor).isActive = true
        middleContainer.topAnchor.constraint(equalTo: topContainer.bottomAnchor).isActive = true
        middleContainer.topAnchor.constraint(equalTo: topContainer.bottomAnchor).priority = .defaultLow
        
        mainContainer.addSubview(bottomContainer)
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false
        bottomContainer.leftAnchor.constraint(equalTo: mainContainer.leftAnchor).isActive = true
        bottomContainer.rightAnchor.constraint(equalTo: mainContainer.rightAnchor).isActive = true
        bottomContainer.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor).isActive = true
        bottomContainer.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        topContainer.addSubview(arrowUpDown)
        arrowUpDown.translatesAutoresizingMaskIntoConstraints = false
        arrowUpDown.rightAnchor.constraint(equalTo: topContainer.rightAnchor, constant: -20).isActive = true
        arrowUpDown.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor).isActive = true
        arrowUpDown.widthAnchor.constraint(equalToConstant: 20).isActive = true
        arrowUpDown.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //MARK: - Констрейнты для визуальных элементов ячейки
        topContainer.addSubview(imageCategory)
        imageCategory.translatesAutoresizingMaskIntoConstraints = false
        imageCategory.leftAnchor.constraint(equalTo: topContainer.leftAnchor, constant: 16).isActive = true
        imageCategory.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor).isActive = true
        imageCategory.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageCategory.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        topContainer.addSubview(labelTitle)
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.leftAnchor.constraint(equalTo: imageCategory.rightAnchor, constant: 16).isActive = true
        labelTitle.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor).isActive = true
        labelTitle.rightAnchor.constraint(equalTo: arrowUpDown.leftAnchor, constant: -32).isActive = true
        labelTitle.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        middleContainer.addSubview(labelDescription)
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.leftAnchor.constraint(equalTo: middleContainer.leftAnchor, constant: 16).isActive = true
        labelDescription.rightAnchor.constraint(equalTo: middleContainer.rightAnchor, constant: -16).isActive = true
        labelDescription.topAnchor.constraint(equalTo: middleContainer.topAnchor, constant: 8).isActive = true
        labelDescription.bottomAnchor.constraint(equalTo: middleContainer.bottomAnchor, constant: -8).isActive = true
        
        bottomContainer.addSubview(labelDate)
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        labelDate.rightAnchor.constraint(equalTo: bottomContainer.rightAnchor).isActive = true
        labelDate.topAnchor.constraint(equalTo: bottomContainer.topAnchor).isActive = true
        labelDate.bottomAnchor.constraint(equalTo: bottomContainer.bottomAnchor).isActive = true
        labelDate.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        bottomContainer.addSubview(labelCategory)
        labelCategory.translatesAutoresizingMaskIntoConstraints = false
        labelCategory.leftAnchor.constraint(equalTo: bottomContainer.leftAnchor, constant: 16).isActive = true
        labelCategory.topAnchor.constraint(equalTo: bottomContainer.topAnchor).isActive = true
        labelCategory.bottomAnchor.constraint(equalTo: bottomContainer.bottomAnchor).isActive = true
        labelCategory.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        //MARK: - Констрейнт для сжатого состояния
        collapsedConstraint = topContainer.bottomAnchor.constraint(equalTo: bottomContainer.topAnchor)
        collapsedConstraint.priority = .defaultLow
        //MARK: - Констрейнт для расширенного состояния
        expandedConstraint = middleContainer.bottomAnchor.constraint(equalTo: bottomContainer.topAnchor)
        expandedConstraint.priority = .defaultLow
        
    }
    //MARK: - При выборе ячейки переключаем констрейнт и анимируем стрелку и подпись категории
    func updateAppearance() {
        collapsedConstraint.isActive = !isSelected
        expandedConstraint.isActive = isSelected
        
        UIView.animate(withDuration: 0.3) {
            self.labelCategory.alpha = self.isSelected ? 1 : 0
            let upDown = CGAffineTransform(rotationAngle: .pi * -0.999)
            self.arrowUpDown.transform = self.isSelected ? upDown : .identity
        }
    }
    
    func borderForCell () {
        self.layer.borderColor = NewsConstants.Collor.borderCell.cgColor
        self.layer.borderWidth = 1
    }
    
    func configure(model: APIDTONews) {
        imageCategory.image = model.categoryImg
        labelTitle.text = model.title
        labelDescription.text = model.description
        labelCategory.text = model.categoryName
        let formate = DateFormatter()
        formate.timeStyle = .none
        formate.dateFormat = "dd.MM.yyyy"
        let publishDate = Date(milliseconds: model.publishDate ?? 0)
        labelDate.text = formate.string(from: publishDate)
    }
    
}


