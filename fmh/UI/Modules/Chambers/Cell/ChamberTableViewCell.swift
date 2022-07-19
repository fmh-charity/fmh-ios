//
//  ChamberTableViewCell.swift
//  fmh
//
//  Created: 14.06.2022
//

import UIKit

class ChamberTableViewCell: UITableViewCell {
    
    // MARK: - Public properties
    
    static let identifier = "ChamberTableViewCell"
    
    // MARK: - Private properties
    
    private lazy var numberOfChamber: UILabel = {
       let label = UILabel(textColor: .gray, font: UIFont(name: "SFNS Display", size: 13), numberOfLines: 1)
        return label
    }()
    
    private lazy var chamber: UILabel = {
        let label = UILabel(textColor: .black, font: UIFont(name: "SF UI Display", size: 16))
        label.textAlignment = .right
        return label
    }()
    
    private lazy var numberOfPost: UILabel = {
       let label = UILabel(textColor: .gray, font: UIFont(name: "SFNS Display", size: 13), numberOfLines: 1)
        return label
    }()
    
    private lazy var post: UILabel = {
        let label = UILabel(textColor: .black, font: UIFont(name: "SF UI Display", size: 16))
        label.textAlignment = .right
        return label
    }()
    
    private lazy var numberOfBlock: UILabel = {
       let label = UILabel(textColor: .gray, font: UIFont(name: "SFNS Display", size: 13), numberOfLines: 1)
        return label
    }()
    
    private lazy var block: UILabel = {
        let label = UILabel(textColor: .black, font: UIFont(name: "SF UI Display", size: 16))
        label.textAlignment = .right
        return label
    }()
    
    private lazy var numberOfFreePlaces: UILabel = {
       let label = UILabel(textColor: .gray, font: UIFont(name: "SFNS Display", size: 13), numberOfLines: 1)
        return label
    }()
    
    private lazy var freePlaces: UILabel = {
        let label = UILabel(textColor: .black, font: UIFont(name: "SF UI Display", size: 16))
        label.textAlignment = .right
        return label
    }()
    
    private lazy var comment: UILabel = {
       let label = UILabel(textColor: .gray, font: UIFont(name: "SFNS Display", size: 13), numberOfLines: 1)
        return label
    }()
    
    private lazy var nameOfComment: UILabel = {
        let label = UILabel(textColor: .black, font: UIFont(name: "SF UI Display", size: 16))
        return label
    }()
    
    private lazy var grayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9118670225, green: 0.9118669629, blue: 0.9118669629, alpha: 1)
        return view
    }()
    
    private lazy var firstSeparatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(cgColor: CGColor(gray: 0.9, alpha: 1))
        return view
    }()
    
    private lazy var secondSeparatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(cgColor: CGColor(gray: 0.9, alpha: 1))
        return view
    }()
    
    private lazy var thirdSeparatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(cgColor: CGColor(gray: 0.9, alpha: 1))
        return view
    }()

    private lazy var patientsView: UIView = {
        let view = PatientsView(labelText: "Пациенты палаты", patientText: "Фурсова М.Г. Нургалеева Е.М. Иванов А.Б. Лукашкин Т.В.", plusButtonImage: UIImage(systemName: "plus.circle"))
        return view
    }()
    
    private lazy var chamberStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [numberOfChamber, chamber], axis: .horizontal, spacing: 0)
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var postStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [numberOfPost, post], axis: .horizontal, spacing: 0)
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var blockStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [numberOfBlock, block], axis: .horizontal, spacing: 0)
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var freePlacesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [numberOfFreePlaces, freePlaces], axis: .horizontal, spacing: 0)
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var commentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [comment, nameOfComment], axis: .vertical, spacing: 0)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [chamberStackView, postStackView, blockStackView, freePlacesStackView], axis: .vertical, spacing: 15)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        return stackView
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstrains()
        backgroundColor = .white
        layer.borderWidth = 0.5
        layer.borderColor = CGColor(gray: 0.75, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func configure(numberOfChamber: String, chamber: String, numberOfPost: String, post: String, numberOfBlock: String, block: String, numberOfFreePlaces: String, freePlaces: String, comment: String, nameOfComment: String) {

        self.numberOfChamber.text = numberOfChamber
        self.chamber.text = chamber
        self.numberOfPost.text = numberOfPost
        self.post.text = post
        self.numberOfBlock.text = numberOfBlock
        self.block.text = block
        self.numberOfFreePlaces.text = numberOfFreePlaces
        self.freePlaces.text = freePlaces
        self.comment.text = comment
        self.nameOfComment.text = nameOfComment
    }
    
}

// MARK: - Add subviews

extension ChamberTableViewCell {
    private func addSubviews() {
        contentView.addSubview(grayView)
        contentView.addSubview(firstSeparatorView)
        contentView.addSubview(secondSeparatorView)
        contentView.addSubview(thirdSeparatorView)
        contentView.addSubview(patientsView)
        contentView.addSubview(mainStackView)
        contentView.addSubview(commentStackView)
    }
}

// MARK: - Setup constraints

extension ChamberTableViewCell {

    private func setupConstrains() {
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: patientsView.topAnchor, constant: -7.5)
        ])
        
        NSLayoutConstraint.activate([
            grayView.topAnchor.constraint(equalTo: contentView.topAnchor),
            grayView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            grayView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            grayView.bottomAnchor.constraint(equalTo: postStackView.topAnchor, constant: -7.5)
        ])
        
        NSLayoutConstraint.activate([
            firstSeparatorView.topAnchor.constraint(equalTo: grayView.bottomAnchor),
            firstSeparatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            firstSeparatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            firstSeparatorView.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        NSLayoutConstraint.activate([
            secondSeparatorView.topAnchor.constraint(equalTo: postStackView.bottomAnchor, constant: 7.5),
            secondSeparatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7.5),
            secondSeparatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7.5),
            secondSeparatorView.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        NSLayoutConstraint.activate([
            thirdSeparatorView.topAnchor.constraint(equalTo: blockStackView.bottomAnchor, constant: 7.5),
            thirdSeparatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7.5),
            thirdSeparatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7.5),
            thirdSeparatorView.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        NSLayoutConstraint.activate([
            patientsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7.5),
            patientsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7.5)
        ])
        
        NSLayoutConstraint.activate([
            commentStackView.topAnchor.constraint(equalTo: patientsView.bottomAnchor, constant: 7.5),
            commentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            commentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            commentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])

    }
    
}
