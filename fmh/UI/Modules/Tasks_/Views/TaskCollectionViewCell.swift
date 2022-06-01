//
//  TaskCollectionViewCell.swift
//  fmh
//
//  Created: 24.05.2022
//

import UIKit

class TaskCollectionViewCell: UICollectionViewCell {
    static let reuseID = "TaskCollectionViewCell"
    let taskView = MainTaskTitle()
    let orangeView = OrangeView()
    
    private let themeLabel = UILabel(text: "Тема", font: UIFont.systemFont(ofSize: 13) , tintColor: UIColor(named: "TaskCollectionTextColor") ?? .black, textAlignment: .left)
    let nameofThemeLabel = UILabel(text: "Тема1", font: UIFont.systemFont(ofSize: 16) , tintColor: .black, textAlignment: .right)
    let executorLabel = UILabel(text: "Исполнитель", font: UIFont.systemFont(ofSize: 13) , tintColor: UIColor(named: "TaskCollectionTextColor") ?? .black, textAlignment: .left)
//    private let bottomArrowButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
//        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 2, right: 2)
//        button.tintColor = UIColor(named: "TaskCollectionTextColor") ?? .black
//        button.contentMode = .scaleAspectFit
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        contentView.clipsToBounds = true
        contentView.addSubview(taskView)
        orangeView.addSubview(themeLabel)
        orangeView.addSubview(nameofThemeLabel)
        contentView.addSubview(orangeView)
        
        let constraints = [
            orangeView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            orangeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            orangeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            orangeView.bottomAnchor.constraint(equalTo: nameofThemeLabel.bottomAnchor),
            
            themeLabel.leadingAnchor.constraint(equalTo: orangeView.leadingAnchor, constant: 10),
            themeLabel.trailingAnchor.constraint(equalTo: nameofThemeLabel.leadingAnchor, constant: -30),
            themeLabel.topAnchor.constraint(equalTo: orangeView.topAnchor, constant: 10),
            themeLabel.bottomAnchor.constraint(equalTo: orangeView.bottomAnchor, constant: -10),
            
            nameofThemeLabel.leadingAnchor.constraint(equalTo: themeLabel.trailingAnchor, constant: 30),
            nameofThemeLabel.trailingAnchor.constraint(equalTo: orangeView.trailingAnchor, constant: -10),
            nameofThemeLabel.topAnchor.constraint(equalTo: orangeView.topAnchor),
            nameofThemeLabel.bottomAnchor.constraint(equalTo: orangeView.bottomAnchor),
            
//            executorLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            executorLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            
//            executorLabel.topAnchor.constraint(equalTo: orangeView.bottomAnchor, constant: 10),
//            executorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
//            executorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
//            executorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
//
//
            taskView.topAnchor.constraint(equalTo: orangeView.bottomAnchor),
            taskView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            taskView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            taskView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),

//
//            bottomArrowButton.topAnchor.constraint(equalTo: taskView.bottomAnchor),
//            bottomArrowButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
//            bottomArrowButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
//            bottomArrowButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
         
        ]
        NSLayoutConstraint.activate(constraints)
        backgroundColor = UIColor(named: "BackgroundTaskCell")
//        bottomArrowButton.backgroundColor = .white
    }
}


