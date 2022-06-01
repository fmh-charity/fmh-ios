//
//  MainTaskTitle.swift
//  fmh
//
//  Created: 26.05.22
//

import UIKit

class AllElementsView: UIView {
    let executorLabel = UILabel(text: "Исполнитель", font: UIFont.systemFont(ofSize: 13) , tintColor: UIColor(named: "TaskCollectionTextColor") ?? .black, textAlignment: .left)
    let nameOfExecutorLabel = UILabel(text: "Исполнитель1", font: UIFont.systemFont(ofSize: 16) , tintColor: .black, textAlignment: .right)
    let planeDateLabel = UILabel(text: "Плановая дата", font: UIFont.systemFont(ofSize: 13) , tintColor: UIColor(named: "TaskCollectionTextColor") ?? .black, textAlignment: .left)
    let dateLabel = UILabel(text: "24.05.2022", font: UIFont.systemFont(ofSize: 16) , tintColor: .black, textAlignment: .right)
    let timeLabel = UILabel(text: "17:00", font: UIFont.systemFont(ofSize: 13) , tintColor: UIColor(named: "TaskCollectionTextColor") ?? .black, textAlignment: .left)
    let topSeparator: UILabel = {
        let separator = UILabel()
        separator.layer.borderWidth = 1
        separator.layer.backgroundColor = UIColor.gray.cgColor
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(executorLabel)
        addSubview(nameOfExecutorLabel)
        addSubview(planeDateLabel)
        addSubview(dateLabel)
        addSubview(timeLabel)
        addSubview(topSeparator)
        let constraints = [
            executorLabel.topAnchor.constraint(equalTo: self.topAnchor),
            executorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            executorLabel.trailingAnchor.constraint(equalTo: nameOfExecutorLabel.leadingAnchor, constant: -2),
            executorLabel.bottomAnchor.constraint(equalTo: topSeparator.topAnchor, constant: -9),
            executorLabel.heightAnchor.constraint(equalToConstant: 32),
            topSeparator.topAnchor.constraint(equalTo: executorLabel.bottomAnchor, constant: 9),
            topSeparator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            topSeparator.trailingAnchor.constraint(equalTo: nameOfExecutorLabel.leadingAnchor, constant: -2),
            topSeparator.bottomAnchor.constraint(equalTo: planeDateLabel.topAnchor, constant: -2),
            topSeparator.heightAnchor.constraint(equalToConstant: 1),
            topSeparator.widthAnchor.constraint(equalTo: planeDateLabel.widthAnchor, multiplier: 0.85),
            nameOfExecutorLabel.topAnchor.constraint(equalTo: self.topAnchor),
            nameOfExecutorLabel.leadingAnchor.constraint(equalTo: executorLabel.trailingAnchor, constant: 2),
            nameOfExecutorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            nameOfExecutorLabel.bottomAnchor.constraint(equalTo: planeDateLabel.topAnchor),
            nameOfExecutorLabel.heightAnchor.constraint(equalToConstant: 32),
            planeDateLabel.topAnchor.constraint(equalTo: topSeparator.bottomAnchor, constant: 2),
            planeDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            planeDateLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -15),
            planeDateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
            planeDateLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            dateLabel.topAnchor.constraint(equalTo: nameOfExecutorLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: planeDateLabel.trailingAnchor, constant: 15),
            dateLabel.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: -2),
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
            timeLabel.topAnchor.constraint(equalTo: nameOfExecutorLabel.bottomAnchor, constant: 5),
            timeLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 3),
            timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2),
            timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            timeLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

class MainTaskTitle: UIView {
  
    
    let elementsView = AllElementsView()
    
    private let bottomArrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 2, right: 2)
        button.tintColor = UIColor(named: "TaskCollectionTextColor") ?? .black
        button.contentMode = .scaleAspectFit
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let bottomSeparator: UILabel = {
        let separator = UILabel()
        separator.layer.borderWidth = 1
        separator.layer.backgroundColor = UIColor.gray.cgColor
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray
        self.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {

        addSubview(elementsView)
        addSubview(bottomArrowButton)
        addSubview(bottomSeparator)
        let constraints = [
            elementsView.topAnchor.constraint(equalTo: self.topAnchor),
            elementsView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),
            elementsView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2),
            elementsView.bottomAnchor.constraint(equalTo: bottomSeparator.topAnchor),
            
            bottomSeparator.topAnchor.constraint(equalTo: elementsView.bottomAnchor),
            bottomSeparator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),
            bottomSeparator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2),
            bottomSeparator.bottomAnchor.constraint(equalTo: bottomArrowButton.topAnchor),
            bottomSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            bottomArrowButton.topAnchor.constraint(equalTo: bottomSeparator.bottomAnchor),
            bottomArrowButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),
            bottomArrowButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2),
            bottomArrowButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
           
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
}
