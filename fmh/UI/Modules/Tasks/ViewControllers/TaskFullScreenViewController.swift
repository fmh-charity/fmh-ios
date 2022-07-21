//
//  TaskFullScreenViewController.swift
//  fmh
//
//  Created: 26.05.22
//

import UIKit

enum StatusOfClaim {
    case opened
    case inwork
    case closed
}

final class TaskFullScreenViewController: UIViewController {
    private let orangeView = OrangeView()
    private let bottomButtons = BottomButtonsView()
    private let taskView = AllElementsView()
    private let descriptionView = DescriptionView()
    private let creatorView = CreatorView()
    private let commentView = CommentsView()
    private let tableView = TableViewScreen()
    private let dropDownButtins = DropDownButtonsView()
    private let statusLabel = UILabel(text: "В работе", font: UIFont(name: "SF UI Display", size: 16), tintColor: .black, textAlignment: .center)
    private let themeLabel = UILabel(text: "Тема", font: UIFont.systemFont(ofSize: 13) , tintColor: UIColor(named: "TaskCollectionTextColor") ?? .black, textAlignment: .left)
    let nameofThemeLabel = UILabel(text: "Тема1", font: UIFont.systemFont(ofSize: 16) , tintColor: .black, textAlignment: .right)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraint()
        workWithComments()
    }
    
    private func setupConstraint() {
        view.addSubview(orangeView)
        orangeView.addSubview(themeLabel)
        orangeView.addSubview(nameofThemeLabel)
        view.addSubview(taskView)
        view.addSubview(statusLabel)
        view.addSubview(descriptionView)
        view.addSubview(creatorView)
        view.addSubview(tableView)
        view.addSubview(bottomButtons)
        view.addSubview(dropDownButtins)
        taskView.backgroundColor = .white
        dropDownButtins.isHidden = true
        bottomButtons.workButton.addTarget(self, action: #selector(changeShowingStatusButtons), for: .touchUpInside)
        bottomButtons.backButton.addTarget(self, action: #selector(closeWindow), for: .touchUpInside)
        dropDownButtins.changeStatusButton.addTarget(self, action: #selector(changedButtonTapped), for: .touchUpInside)
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
            tableView.bottomAnchor.constraint(equalTo: bottomButtons.topAnchor, constant: -10),
            dropDownButtins.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 180),
            dropDownButtins.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            dropDownButtins.bottomAnchor.constraint(equalTo: bottomButtons.topAnchor),
            bottomButtons.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 25),
            bottomButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            bottomButtons.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            bottomButtons.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        tableView.layer.shadowOffset = CGSize(width: 1, height: 4)
        tableView.layer.shadowRadius = 4
        tableView.layer.shadowOpacity = 0.25
        taskView.backgroundColor = .white
        NSLayoutConstraint.activate(constraints)
        descriptionView.descriptionLabel.text = "Нужно собрать коллектив в переговорной. Будем обсуждать подготовку к новогодним праздникам."
    }
    
    @objc private func closeWindow() {
        dismiss(animated: true)
    }
    
    @objc private func changeShowingStatusButtons() {
        dropDownButtins.isHidden = dropDownButtins.isHidden ? false : true
        switch statusLabel.text {
        case "Открыта":
            dropDownButtins.changeStatusButton.setTitle("Взять в работу", for: .normal)
            break
        case "В работе":
            dropDownButtins.changeStatusButton.setTitle("Завершить", for: .normal)
            break
        default: dropDownButtins.changeStatusButton.setTitle("Открыть", for: .normal)
            break
        }
    }
    
    @objc private func changedButtonTapped() {
        switch statusLabel.text {
        case "Открыта":
            statusLabel.backgroundColor = UIColor(named: "Status.active") ?? .systemGray6
            statusLabel.text = "В работе"
            dropDownButtins.isHidden = true
            break
        case "В работе":
            statusLabel.backgroundColor = UIColor.lightGray
            statusLabel.text = "Закрыта"
            dropDownButtins.isHidden = true
            break
        default:
            statusLabel.backgroundColor = UIColor.lightGray
            statusLabel.text = "Открыта"
            dropDownButtins.isHidden = true
            break
        }
    }
    
    private func workWithComments() {
        tableView.newCommentComplition = {[weak self] in
            let alertController = UIAlertController(title: "Новый комментарий", message: "", preferredStyle: UIAlertController.Style.alert)
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Введите текст комментария"
            }
            let saveAction = UIAlertAction(title: "Сохранить", style: UIAlertAction.Style.default, handler: {
                (action: UIAlertAction!) -> Void in
                commentCellModels.append(CommenModelData(comment: alertController.textFields?.first?.text ?? "", creatorName: "Максим В.В.", date: "31.05.2022", time: "14:44"))
                self?.tableView.tableView?.reloadData()
            })
            let cancelAction = UIAlertAction(title: "Отмена", style: UIAlertAction.Style.default, handler: {
                (action : UIAlertAction!) -> Void in })
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            self?.present(alertController, animated: true, completion: nil)
        }
        
        tableView.editCommentComplition = {[weak self] index in
            let alertController = UIAlertController(title: "Новый комментарий", message: "", preferredStyle: UIAlertController.Style.alert)
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.text = commentCellModels[index].comment
            }
            let saveAction = UIAlertAction(title: "Сохранить", style: UIAlertAction.Style.default, handler: {
                (action: UIAlertAction!) -> Void in
                commentCellModels[index].comment = alertController.textFields?.first?.text ?? ""
                self?.tableView.tableView?.reloadData()
            })
            let cancelAction = UIAlertAction(title: "Отмена", style: UIAlertAction.Style.default, handler: {
                (action : UIAlertAction!) -> Void in })
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            self?.present(alertController, animated: true, completion: nil)
        }
    }
}
