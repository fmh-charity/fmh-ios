//
//  EditTaskViewController.swift
//  fmh
//
//  Created: 03.06.2022
//

import UIKit

class EditTaskViewController: UIViewController {

    let customView = EditTaskView()

    let pickerView = UIPickerView()

    let names = ["asdsad", "asd21312sad","виталик","хуй","asdsad","asdsad",]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(customView)
//        view.addSubview(pickerView)
        pickerView.isHidden = true
        customView.executorTextField.inputView = pickerView
        pickerView.dataSource = self
        pickerView.delegate = self
        view.backgroundColor = .white
        setupElements()
    }

    func setupElements() {
        customView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        customView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        customView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        customView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        customView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
    }
}

extension EditTaskViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return names.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return names[row]
    }
}
