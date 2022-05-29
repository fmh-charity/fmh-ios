//
//  TaskFullScreenViewController.swift
//  fmh
//
//  Created: 26.05.22
//

import UIKit

final class TaskFullScreenViewController: UIViewController {
    let taskView = MainTaskTitle()
    let descriptionView = DescriptionView()
    let creatorView = CreatorView()
    let commentView = CommentsView()
    let tableView = TableViewScreen()
    let statusLabel = UILabel(text: "В работе", font: UIFont(name: "SF UI Display", size: 16), tintColor: .black, textAlignment: .center)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraint()
    }
    
    func setupConstraint() {
        view.addSubview(taskView)
        view.addSubview(statusLabel)
        view.addSubview(descriptionView)
        view.addSubview(creatorView)
        view.addSubview(tableView)
        taskView.backgroundColor = .white
        statusLabel.backgroundColor = UIColor(named: "Status.active") ?? .systemGray6
        let constraints = [
            taskView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
            tableView.topAnchor.constraint(equalTo: creatorView.bottomAnchor, constant: 2),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            
//            commentView.topAnchor.constraint(equalTo: creatorView.bottomAnchor, constant: 2),
//            commentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
//            commentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),
//            commentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            
        ]
        NSLayoutConstraint.activate(constraints)
        descriptionView.descriptionLabel.text = "Нужно собрать коллектив в переговорной. Будем обсуждать подготовку к новогодним праздникам."
    }
}
