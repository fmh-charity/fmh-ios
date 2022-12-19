//
//  DetailsNewsCollectionViewCell.swift
//  fmh
//
//  Created: 24.05.2022
//

import UIKit

protocol DetailsNewsCollectionViewCellDelegate: AnyObject {
    
    func editDetailsNewsCollectionViewCellDelegate(_ detailsCell: UICollectionViewCell, didClickEditButton index: Int)
    func deleteDetailsNewsCollectionViewCellDelegate(_ detailsCell: UICollectionViewCell, didClickDeleteButton index: Int)
}

final class DetailsNewsCollectionViewCell: UICollectionViewCell {
    var index = 0
    weak var delegate: DetailsNewsCollectionViewCellDelegate?
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
    private lazy var middleContainerPublic = UIView()
    private lazy var middleContainerCreate = UIView()
    private lazy var middleContainerAuthor = UIView()
    private lazy var bottomContainer = UIView()
    private lazy var footerContainer = UIView()
    
    private lazy var imageCategory: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.text = "Новостной заголовок"
        label.numberOfLines = 2
        label.font = NewsConstants.Font.titleNews
        return label
    }()
    
    private lazy var labelPleaceHolderPublic: UILabel = {
        let label = UILabel()
        label.font = NewsConstants.Font.holder
        label.textColor = NewsConstants.Collor.holderText
        label.text = "Дата публикации"
        return label
    }()
    
    private lazy var labelPublic: UILabel = {
        let label = UILabel()
        label.font = NewsConstants.Font.holder
        label.textColor = NewsConstants.Collor.holderText
        label.backgroundColor = NewsConstants.Collor.fillRectangel
        label.text = "22.12.2022"
        return label
    }()
    
    private lazy var labelPleaceHolderCreate: UILabel = {
        let label = UILabel()
        label.font = NewsConstants.Font.holder
        label.textColor = NewsConstants.Collor.holderText
        label.text = "Дата создания"
        return label
    }()
    
    private lazy var labelCreate: UILabel = {
        let label = UILabel()
        label.font = NewsConstants.Font.holder
        label.textColor = NewsConstants.Collor.holderText
        label.backgroundColor = NewsConstants.Collor.fillRectangel
        label.text = "22.12.2022"
        return label
    }()
    
    private lazy var labelPleaceHolderAuthor: UILabel = {
        let label = UILabel()
        label.font = NewsConstants.Font.holder
        label.textColor = NewsConstants.Collor.holderText
        label.text = "Автор"
        return label
    }()
    
    private lazy var labelAuthor: UILabel = {
        let label = UILabel()
        label.font = NewsConstants.Font.holder
        label.textColor = NewsConstants.Collor.holderText
        label.backgroundColor = NewsConstants.Collor.fillRectangel
        label.text = "Паратова К.И."
        return label
    }()
    
    private lazy var labelisActive: UILabel = {
        let label = UILabel()
        label.font = NewsConstants.Font.holder
        label.textColor = NewsConstants.Collor.holderText
        label.text = "✓ АКТИВНА"
        return label
    }()
    
    private lazy var buttonTrash: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "nb.trash"), for: .normal)
        button.addTarget(self, action: #selector(deleteCellAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonEdit: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "nb.edit"), for: .normal)
        button.addTarget(self, action: #selector(editNewsAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var arrowUpDown: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: NewsConstants.Images.chevronDown)?.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = NewsConstants.Collor.chevron
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var labelDescription: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = NewsConstants.Font.descriptionNews
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()
    
    //MARK: - action for button in the cell
    @objc private func deleteCellAction(button: UIButton) {
        print("tap delete button")
        delegate?.deleteDetailsNewsCollectionViewCellDelegate(self, didClickDeleteButton: index)
    }
    
    @objc private func editNewsAction(button: UIButton) {

        print("tap button editNews ")
        delegate?.editDetailsNewsCollectionViewCellDelegate(self, didClickEditButton: index)
    }

    func configure(model: APIDTONews) {
        imageCategory.image = model.categoryImg
        labelTitle.text = model.title
        labelDescription.text = model.description
        labelAuthor.text = shortName(name: model.creatorName!)
        let formate = DateFormatter()
        formate.timeStyle = .none
        formate.dateFormat = "dd.MM.yyyy"
        let createDate = Date(milliseconds: model.createDate ?? 0)
        let publishDate = Date(milliseconds: model.publishDate ?? 0)
        guard let publishEnabled = model.publishEnabled else { return }
        labelCreate.text = formate.string(from: createDate)
        labelPublic.text = formate.string(from: publishDate)
        labelisActive.text = publishEnabled ? "✓ АКТИВНА" : "╳ НЕ АКТИВНА"

    }
}
    //MARK: - configure cell
private extension DetailsNewsCollectionViewCell {

    func configureCell() {
        mainContainer.clipsToBounds = true
        borderForView(viewForBorder: self)
        topContainer.backgroundColor = .white
        middleContainerPublic.backgroundColor = .white
        borderForView(viewForBorder: middleContainerPublic)
        middleContainerCreate.backgroundColor = .white
        middleContainerAuthor.backgroundColor = .white
        borderForView(viewForBorder: middleContainerAuthor)
        bottomContainer.backgroundColor = .white
        footerContainer.backgroundColor = .white

    // MARK: Ограничиваем область нажатия для расширения ячейки через костыли(
        let tapGesture = UITapGestureRecognizer()
        topContainer.addGestureRecognizer(tapGesture)

        let tapGesture1 = UITapGestureRecognizer()
        middleContainerPublic.addGestureRecognizer(tapGesture1)

        let tapGesture2 = UITapGestureRecognizer()
        middleContainerAuthor.addGestureRecognizer(tapGesture2)

        let tapGesture3 = UITapGestureRecognizer()
        middleContainerCreate.addGestureRecognizer(tapGesture3)

        let tapGesture4 = UITapGestureRecognizer()
        footerContainer.addGestureRecognizer(tapGesture4)

        makeConstraint()
        updateAppearance()
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

        mainContainer.addSubview(middleContainerPublic)
        middleContainerPublic.translatesAutoresizingMaskIntoConstraints = false
        middleContainerPublic.leftAnchor.constraint(equalTo: mainContainer.leftAnchor).isActive = true
        middleContainerPublic.rightAnchor.constraint(equalTo: mainContainer.rightAnchor).isActive = true
        middleContainerPublic.topAnchor.constraint(equalTo: topContainer.bottomAnchor).isActive = true
        middleContainerPublic.heightAnchor.constraint(equalToConstant: 18).isActive = true

        mainContainer.addSubview(middleContainerCreate)
        middleContainerCreate.translatesAutoresizingMaskIntoConstraints = false
        middleContainerCreate.leftAnchor.constraint(equalTo: mainContainer.leftAnchor).isActive = true
        middleContainerCreate.rightAnchor.constraint(equalTo: mainContainer.rightAnchor).isActive = true
        middleContainerCreate.topAnchor.constraint(equalTo: middleContainerPublic.bottomAnchor).isActive = true
        middleContainerCreate.heightAnchor.constraint(equalToConstant: 18).isActive = true

        mainContainer.addSubview(middleContainerAuthor)
        middleContainerAuthor.translatesAutoresizingMaskIntoConstraints = false
        middleContainerAuthor.leftAnchor.constraint(equalTo: mainContainer.leftAnchor).isActive = true
        middleContainerAuthor.rightAnchor.constraint(equalTo: mainContainer.rightAnchor).isActive = true
        middleContainerAuthor.topAnchor.constraint(equalTo: middleContainerCreate.bottomAnchor).isActive = true
        middleContainerAuthor.heightAnchor.constraint(equalToConstant: 18).isActive = true

        mainContainer.addSubview(bottomContainer)
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false
        bottomContainer.leftAnchor.constraint(equalTo: mainContainer.leftAnchor).isActive = true
        bottomContainer.rightAnchor.constraint(equalTo: mainContainer.rightAnchor).isActive = true
        bottomContainer.topAnchor.constraint(equalTo: middleContainerAuthor.bottomAnchor).isActive = true
        bottomContainer.heightAnchor.constraint(equalToConstant: 55).isActive = true

        mainContainer.addSubview(footerContainer)
        footerContainer.translatesAutoresizingMaskIntoConstraints = false
        footerContainer.leftAnchor.constraint(equalTo: mainContainer.leftAnchor).isActive = true
        footerContainer.rightAnchor.constraint(equalTo: mainContainer.rightAnchor).isActive = true
        footerContainer.topAnchor.constraint(equalTo: bottomContainer.bottomAnchor).isActive = true

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
        labelTitle.rightAnchor.constraint(equalTo: topContainer.rightAnchor, constant: -50).isActive = true
        labelTitle.heightAnchor.constraint(equalToConstant: 45).isActive = true

        middleContainerPublic.addSubview(labelPleaceHolderPublic)
        labelPleaceHolderPublic.translatesAutoresizingMaskIntoConstraints = false
        labelPleaceHolderPublic.leftAnchor.constraint(equalTo: middleContainerPublic.leftAnchor, constant: 16).isActive = true
        labelPleaceHolderPublic.centerYAnchor.constraint(equalTo: middleContainerPublic.centerYAnchor).isActive = true
        labelPleaceHolderPublic.widthAnchor.constraint(equalTo: middleContainerPublic.widthAnchor, multiplier: 0.6).isActive = true

        middleContainerPublic.addSubview(labelPublic)
        labelPublic.translatesAutoresizingMaskIntoConstraints = false
        labelPublic.rightAnchor.constraint(equalTo: middleContainerPublic.rightAnchor).isActive = true
        labelPublic.centerYAnchor.constraint(equalTo: middleContainerPublic.centerYAnchor).isActive = true
        labelPublic.heightAnchor.constraint(equalToConstant: 18).isActive = true
        labelPublic.widthAnchor.constraint(equalTo: middleContainerPublic.widthAnchor, multiplier: 0.4).isActive = true

        middleContainerCreate.addSubview(labelPleaceHolderCreate)
        labelPleaceHolderCreate.translatesAutoresizingMaskIntoConstraints = false
        labelPleaceHolderCreate.leftAnchor.constraint(equalTo: middleContainerCreate.leftAnchor, constant: 16).isActive = true
        labelPleaceHolderCreate.centerYAnchor.constraint(equalTo: middleContainerCreate.centerYAnchor).isActive = true
        labelPleaceHolderCreate.widthAnchor.constraint(equalTo: middleContainerCreate.widthAnchor, multiplier: 0.6).isActive = true

        middleContainerCreate.addSubview(labelCreate)
        labelCreate.translatesAutoresizingMaskIntoConstraints = false
        labelCreate.rightAnchor.constraint(equalTo: middleContainerCreate.rightAnchor).isActive = true
        labelCreate.centerYAnchor.constraint(equalTo: middleContainerCreate.centerYAnchor).isActive = true
        labelCreate.heightAnchor.constraint(equalToConstant: 18).isActive = true
        labelCreate.widthAnchor.constraint(equalTo: middleContainerCreate.widthAnchor, multiplier: 0.4).isActive = true

        middleContainerAuthor.addSubview(labelPleaceHolderAuthor)
        labelPleaceHolderAuthor.translatesAutoresizingMaskIntoConstraints = false
        labelPleaceHolderAuthor.leftAnchor.constraint(equalTo: middleContainerAuthor.leftAnchor, constant: 16).isActive = true
        labelPleaceHolderAuthor.centerYAnchor.constraint(equalTo: middleContainerAuthor.centerYAnchor).isActive = true
        labelPleaceHolderAuthor.widthAnchor.constraint(equalTo: middleContainerAuthor.widthAnchor, multiplier: 0.6).isActive = true

        middleContainerAuthor.addSubview(labelAuthor)
        labelAuthor.translatesAutoresizingMaskIntoConstraints = false
        labelAuthor.rightAnchor.constraint(equalTo: middleContainerAuthor.rightAnchor).isActive = true
        labelAuthor.centerYAnchor.constraint(equalTo: middleContainerAuthor.centerYAnchor).isActive = true
        labelAuthor.heightAnchor.constraint(equalToConstant: 18).isActive = true
        labelAuthor.widthAnchor.constraint(equalTo: middleContainerAuthor.widthAnchor, multiplier: 0.4).isActive = true


        bottomContainer.addSubview(labelisActive)
        labelisActive.translatesAutoresizingMaskIntoConstraints = false
        labelisActive.leftAnchor.constraint(equalTo: bottomContainer.leftAnchor, constant: 16).isActive = true
        labelisActive.centerYAnchor.constraint(equalTo: bottomContainer.centerYAnchor).isActive = true
        labelisActive.widthAnchor.constraint(equalToConstant: 120).isActive = true

        bottomContainer.addSubview(arrowUpDown)
        arrowUpDown.translatesAutoresizingMaskIntoConstraints = false
        arrowUpDown.rightAnchor.constraint(equalTo: bottomContainer.rightAnchor, constant: -20).isActive = true
        arrowUpDown.centerYAnchor.constraint(equalTo: bottomContainer.centerYAnchor).isActive = true
        arrowUpDown.widthAnchor.constraint(equalToConstant: 20).isActive = true
        arrowUpDown.heightAnchor.constraint(equalToConstant: 20).isActive = true

        bottomContainer.addSubview(buttonEdit)
        buttonEdit.translatesAutoresizingMaskIntoConstraints = false
        buttonEdit.rightAnchor.constraint(equalTo: arrowUpDown.leftAnchor, constant: -25).isActive = true
        buttonEdit.centerYAnchor.constraint(equalTo: bottomContainer.centerYAnchor).isActive = true
        buttonEdit.widthAnchor.constraint(equalToConstant: 20).isActive = true
        buttonEdit.heightAnchor.constraint(equalToConstant: 20).isActive = true

        bottomContainer.addSubview(buttonTrash)
        buttonTrash.translatesAutoresizingMaskIntoConstraints = false
        buttonTrash.rightAnchor.constraint(equalTo: buttonEdit.leftAnchor, constant: -25).isActive = true
        buttonTrash.centerYAnchor.constraint(equalTo: bottomContainer.centerYAnchor).isActive = true
        buttonTrash.widthAnchor.constraint(equalToConstant: 20).isActive = true
        buttonTrash.heightAnchor.constraint(equalToConstant: 20).isActive = true

        footerContainer.addSubview(labelDescription)
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.rightAnchor.constraint(equalTo: footerContainer.rightAnchor, constant: -16).isActive = true
        labelDescription.leftAnchor.constraint(equalTo: footerContainer.leftAnchor, constant: 16).isActive = true
        labelDescription.topAnchor.constraint(equalTo: footerContainer.topAnchor, constant: 8).isActive = true
        labelDescription.bottomAnchor.constraint(equalTo: footerContainer.bottomAnchor, constant: -8).isActive = true


        //MARK: - Констрейнт для сжатого состояния
        collapsedConstraint = bottomContainer.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor)
        collapsedConstraint.priority = .defaultLow
        //MARK: - Констрейнт для расширенного состояния
        expandedConstraint = footerContainer.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor)
        expandedConstraint.priority = .defaultLow


    }
    func borderForView (viewForBorder: UIView) {
        viewForBorder.layer.borderColor = NewsConstants.Collor.borderCell.cgColor
        viewForBorder.layer.borderWidth = 1
    }

    func updateAppearance() {
        collapsedConstraint.isActive = !isSelected
        expandedConstraint.isActive = isSelected

        UIView.animate(withDuration: 0.3) {
            let upDown = CGAffineTransform(rotationAngle: .pi * -0.999)
            self.arrowUpDown.transform = self.isSelected ? upDown : .identity
        }
    }

    private func shortName(name: String) -> String {
        let fullNameArray = name.components(separatedBy: " ")
        var short = ""
        for i in 0...fullNameArray.count - 1 where fullNameArray.count <= 3{
            if i == 0 {
                short = fullNameArray[0]
            } else {
                short += " \(fullNameArray[i].first ?? "?")."
            }
        }
        return short
    }
}
