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
         taskModelCells.append(TaskModel(nameOfTheme: customView.themeTextField.text ?? "",
                                         nameOfExecutor: customView.executorTextField.text ?? "",
                                         date: customView.dateTextField.text ?? "",
                                         time: customView.timeTextField.text ?? "", description: customView.descriptionTextField.text ?? "", status: "Work"))
         self.dismiss(animated: true)
     }
     
     @objc private func cancelEditTask(_ sender: UIButton) {
         self.dismiss(animated: true)
     }
}
