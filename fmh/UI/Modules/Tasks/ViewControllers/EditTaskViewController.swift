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

    let names = ["asdsad", "asd21312sad","виталик","qweqw","asdsad","asdsad",]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(customView)
        pickerView.isHidden = true
        customView.executorTextField.delegate = self
        pickerView.dataSource = self
        pickerView.delegate = self
        customView.executorTextField.inputView = pickerView
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

extension EditTaskViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickerView.isHidden = false
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return names.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return names[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        customView.executorTextField.text = names[row]
        customView.executorTextField.endEditing(true)
    }
}
