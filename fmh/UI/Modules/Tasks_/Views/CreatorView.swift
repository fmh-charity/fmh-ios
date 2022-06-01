//
//  CreatorView.swift
//  fmh
//
//  Created: 26.05.22
//

import UIKit

class CreatorView: UIView {

    let executorLabel = UILabel(text: "Исполнитель", font: UIFont(name: "SFNS Display", size: 12) , tintColor: UIColor(named: "TaskCollectionTextColor") ?? .black, textAlignment: .left)
    let nameOfExecutorLabel = UILabel(text: "Исполнитель1", font: UIFont(name: "Roboto", size: 15) , tintColor: .black, textAlignment: .right)
    let planeDateLabel = UILabel(text: "Плановая дата", font: UIFont(name: "SFNS Display", size: 12) , tintColor: UIColor(named: "TaskCollectionTextColor") ?? .black, textAlignment: .left)
    let dateLabel = UILabel(text: "24.05.2022", font: UIFont(name: "Roboto", size: 15) , tintColor: .black, textAlignment: .right)
    let timeLabel = UILabel(text: "17:00", font: UIFont(name: "Roboto", size: 12) , tintColor: UIColor(named: "TaskCollectionTextColor") ?? .black, textAlignment: .right)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        let middleStackView = UIStackView(views: [executorLabel, nameOfExecutorLabel], axis: .horizontal, spacing: 40, alignment: .fill, distribution: .fillEqually)
        let bottomStackView = UIStackView(views: [planeDateLabel, dateLabel], axis: .horizontal, spacing: 50, alignment: .fill, distribution: .fillEqually)
        
        addSubview(middleStackView)
        addSubview(bottomStackView)
        addSubview(timeLabel)
        
        let constraints = [
            middleStackView.topAnchor.constraint(equalTo: self.topAnchor),
            middleStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),
            middleStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2),
            middleStackView.bottomAnchor.constraint(equalTo: bottomStackView.topAnchor),
            middleStackView.heightAnchor.constraint(equalToConstant: 32),
            bottomStackView.topAnchor.constraint(equalTo: middleStackView.bottomAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),
            bottomStackView.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: -5),
            bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomStackView.heightAnchor.constraint(equalToConstant: 32),
            nameOfExecutorLabel.trailingAnchor.constraint(equalTo: middleStackView.trailingAnchor, constant: -7),
            executorLabel.leadingAnchor.constraint(equalTo: middleStackView.leadingAnchor, constant: 10),
            planeDateLabel.leadingAnchor.constraint(equalTo: bottomStackView.leadingAnchor, constant: 10),
            timeLabel.topAnchor.constraint(equalTo: bottomStackView.topAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            timeLabel.leadingAnchor.constraint(equalTo: bottomStackView.trailingAnchor, constant: 5),
            timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            timeLabel.widthAnchor.constraint(equalToConstant: 45)
        ]
        NSLayoutConstraint.activate(constraints)
        backgroundColor = .white
        middleStackView.backgroundColor = .white
        bottomStackView.backgroundColor = .white
    }
}
