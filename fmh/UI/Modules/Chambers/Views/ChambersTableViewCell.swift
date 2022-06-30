//
//  ChambersTableViewCell.swift
//  fmh
//
//  Created: 30.06.2022
//

import UIKit

class ChambersTableViewCell: UITableViewCell {
    
    static let identifier = "ChambersTableViewCell"
    
    let numberOfChamber = UILabel(textColor: .gray, font: UIFont(name: "SFNS Display", size: 13), numberOfLines: 1)
    let chamber = UILabel(textColor: .black, font: UIFont(name: "SF UI Display", size: 16))
    
    let numberOfPost = UILabel(textColor: .gray, font: UIFont(name: "SFNS Display", size: 13), numberOfLines: 1)
    let post = UILabel(textColor: .black, font: UIFont(name: "SF UI Display", size: 16))
    
    let numberOfBlock = UILabel(textColor: .gray, font: UIFont(name: "SFNS Display", size: 13), numberOfLines: 1)
    let block = UILabel(textColor: .black, font: UIFont(name: "SF UI Display", size: 16))
    
    let numberOfFreePlaces = UILabel(textColor: .gray, font: UIFont(name: "SFNS Display", size: 13), numberOfLines: 1)
    let freePlaces = UILabel(textColor: .black, font: UIFont(name: "SF UI Display", size: 16))
    
    let comment = UILabel(textColor: .gray, font: UIFont(name: "SFNS Display", size: 13), numberOfLines: 1)
    let nameOfComment = UILabel(textColor: .black, font: UIFont(name: "SF UI Display", size: 16))
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstrains()
        backgroundColor = .white
        layer.borderWidth = 0.5
        layer.borderColor = CGColor(gray: 0.75, alpha: 1)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupConstrains() {
        
        chamber.textAlignment = .right
        post.textAlignment = .right
        block.textAlignment = .right
        freePlaces.textAlignment = .right
        
        let orangeView = UIView()
        orangeView.translatesAutoresizingMaskIntoConstraints = false
        orangeView.backgroundColor = UIColor(named: "peach")
        
        contentView.addSubview(orangeView)
        
        let firstSeparatorView = UIView()
        firstSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        firstSeparatorView.backgroundColor = UIColor(cgColor: CGColor(gray: 0.9, alpha: 1))
        
        contentView.addSubview(firstSeparatorView)
        
        let secondSeparatorView = UIView()
        secondSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        secondSeparatorView.backgroundColor = UIColor(cgColor: CGColor(gray: 0.9, alpha: 1))
        
        contentView.addSubview(secondSeparatorView)
        
        let thirdSeparatorView = UIView()
        thirdSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        thirdSeparatorView.backgroundColor = UIColor(cgColor: CGColor(gray: 0.9, alpha: 1))
        
        contentView.addSubview(thirdSeparatorView)
        
        let fourthSeparatorView = UIView()
        fourthSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        fourthSeparatorView.backgroundColor = UIColor(cgColor: CGColor(gray: 0.9, alpha: 1))
        
        contentView.addSubview(fourthSeparatorView)
        
        let chamberStackView = UIStackView(arrangedSubviews: [numberOfChamber, chamber], axis: .horizontal, spacing: 0)
        let postStackView = UIStackView(arrangedSubviews: [numberOfPost, post], axis: .horizontal, spacing: 0)
        let blockStackView = UIStackView(arrangedSubviews: [numberOfBlock, block], axis: .horizontal, spacing: 0)
        let freePlacesStackView = UIStackView(arrangedSubviews: [numberOfFreePlaces, freePlaces], axis: .horizontal, spacing: 0)
        let commentStackView = UIStackView(arrangedSubviews: [comment, nameOfComment], axis: .vertical, spacing: 0)
        
        chamberStackView.distribution = .fillEqually
        postStackView.distribution = .fillEqually
        blockStackView.distribution = .fillEqually
        freePlacesStackView.distribution = .fillEqually
        commentStackView.distribution = .fill
        
        let mainStackView = UIStackView(arrangedSubviews: [chamberStackView, postStackView, blockStackView, freePlacesStackView, commentStackView], axis: .vertical, spacing: 15)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.distribution = .fill
        
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            orangeView.topAnchor.constraint(equalTo: contentView.topAnchor),
            orangeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            orangeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            orangeView.bottomAnchor.constraint(equalTo: postStackView.topAnchor, constant: -7.5)
        ])
        
        NSLayoutConstraint.activate([
            firstSeparatorView.topAnchor.constraint(equalTo: orangeView.bottomAnchor),
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
            fourthSeparatorView.topAnchor.constraint(equalTo: freePlacesStackView.bottomAnchor, constant: 7.5),
            fourthSeparatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7.5),
            fourthSeparatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7.5),
            fourthSeparatorView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
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
