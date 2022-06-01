//
//  TaskFullScreenViewController.swift
//  fmh
//
//  Created: 26.05.22
//

import UIKit

final class TaskFullScreenViewController: UIViewController {
    let orangeView = OrangeView()
    let taskView = AllElementsView()
    let descriptionView = DescriptionView()
    let creatorView = CreatorView()
    let commentView = CommentsView()
    let tableView = TableViewScreen()
    let statusLabel = UILabel(text: "В работе", font: UIFont(name: "SF UI Display", size: 16), tintColor: .black, textAlignment: .center)
    private let themeLabel = UILabel(text: "Тема", font: UIFont.systemFont(ofSize: 13) , tintColor: UIColor(named: "TaskCollectionTextColor") ?? .black, textAlignment: .left)
    let nameofThemeLabel = UILabel(text: "Тема1", font: UIFont.systemFont(ofSize: 16) , tintColor: .black, textAlignment: .right)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraint()
    }
    
    func setupConstraint() {
        view.addSubview(orangeView)
        orangeView.addSubview(themeLabel)
        orangeView.addSubview(nameofThemeLabel)
        view.addSubview(taskView)
        view.addSubview(statusLabel)
        view.addSubview(descriptionView)
        view.addSubview(creatorView)
        view.addSubview(tableView)
        taskView.backgroundColor = .white
        statusLabel.backgroundColor = UIColor(named: "Status.active") ?? .systemGray6
        let constraints = [
            orangeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            orangeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            orangeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            orangeView.bottomAnchor.constraint(equalTo: nameofThemeLabel.bottomAnchor),
            themeLabel.leadingAnchor.constraint(equalTo: orangeView.leadingAnchor, constant: 10),
            themeLabel.trailingAnchor.constraint(equalTo: nameofThemeLabel.leadingAnchor, constant: -30),
            themeLabel.topAnchor.constraint(equalTo: orangeView.topAnchor, constant: 10),
            themeLabel.bottomAnchor.constraint(equalTo: orangeView.bottomAnchor, constant: -10),
            nameofThemeLabel.leadingAnchor.constraint(equalTo: themeLabel.trailingAnchor, constant: 30),
            nameofThemeLabel.trailingAnchor.constraint(equalTo: orangeView.trailingAnchor, constant: -10),
            nameofThemeLabel.topAnchor.constraint(equalTo: orangeView.topAnchor),
            nameofThemeLabel.bottomAnchor.constraint(equalTo: orangeView.bottomAnchor),
            taskView.topAnchor.constraint(equalTo: orangeView.bottomAnchor),
            taskView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taskView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            taskView.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: -9),
            statusLabel.topAnchor.constraint(equalTo: taskView.bottomAnchor, constant: 9),
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.bottomAnchor.constraint(equalTo: descriptionView.topAnchor, constant: -9),
            statusLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            statusLabel.heightAnchor.constraint(equalTo: statusLabel.widthAnchor, multiplier: 1/3),
            descriptionView.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 9),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            descriptionView.bottomAnchor.constraint(equalTo: creatorView.topAnchor, constant: -2),
            creatorView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 2),
            creatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            creatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            creatorView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -2),
            tableView.topAnchor.constraint(equalTo: creatorView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
        ]
        
        tableView.layer.shadowOffset = CGSize(width: 1, height: 4)
        tableView.layer.shadowRadius = 4
        tableView.layer.shadowOpacity = 0.25
        taskView.backgroundColor = .white
        NSLayoutConstraint.activate(constraints)
        descriptionView.descriptionLabel.text = "Нужно собрать коллектив в переговорной. Будем обсуждать подготовку к новогодним праздникам."
    }
}
