//
//  CreateTaskViewController.swift
//  fmh
//
//  Created: 02.06.2022
//

import UIKit

final class CreateTaskViewController: UIViewController {

    private let customView = EditTaskView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        view.addSubview(customView)
        customView.saveButton.addTarget(self, action: #selector(saveTask(_:)), for: .touchUpInside)
        customView.cancelButton.addTarget(self, action: #selector(cancelEditTask(_:)), for: .touchUpInside)
        customView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        customView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        customView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        customView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        customView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
    }
     @objc private func saveTask(_ sender: UIButton) {
         taskModelCells.append(DTOTask(createDate: getCurrentDate(),
                 creatorId: 2,
                 creatorName: "Max",
                 description: customView.descriptionTextField.text ?? "",
                 executorId: 2,
                 executorName: customView.executorTextField.text ?? "",
                 factExecuteDate: 0,
                 id: 2,
                 planExecuteDate: formatDateFromStringToInt(date: customView.dateTextField.text ?? "27.04.1998",
                                                            time: customView.timeTextField.text ?? "08:30"),
                 status: "Open",
                 title: customView.themeTextField.text ?? ""))
         self.dismiss(animated: true)
     }
     
     @objc private func cancelEditTask(_ sender: UIButton) {
         self.dismiss(animated: true)
     }
}
