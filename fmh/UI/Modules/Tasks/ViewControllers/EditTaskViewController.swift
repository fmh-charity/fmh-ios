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


    let datePicker = UIDatePicker()

    let timePicker = UIDatePicker()

    let names = ["asdsad", "asd21312sad","виталик","qweqw","asdsad","asdsad",]

    override func viewDidLoad() {
        super.viewDidLoad()
        let frame1 = CGRect(x: 0, y: 0, width: 300, height: 300)
        datePicker.frame =  frame1
        view.addSubview(customView)
        customView.executorTextField.delegate = self
        pickerView.dataSource = self
        pickerView.delegate = self
        customView.executorTextField.inputView = pickerView
        view.backgroundColor = .white
        setupElements()
        createDatePicker()
        createTimePicker()
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
        datePicker.isHidden = false
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

extension EditTaskViewController {
    func createDatePicker() {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 50)))
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: nil,
                                         action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        if #available(iOS 13.4, *) {
           datePicker.preferredDatePickerStyle = .wheels
        }

        datePicker.datePickerMode = .date
        customView.dateTextField.inputAccessoryView = toolbar
        customView.dateTextField.inputView = datePicker
    }

    @objc func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        customView.dateTextField.text = dateFormatter.string(from: datePicker.date)
        customView.dateTextField.endEditing(true)
    }
}

extension EditTaskViewController {
    func createTimePicker() {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 50)))
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: nil,
                                         action: #selector(doneTimePressed))
        toolbar.setItems([doneButton], animated: true)
        if #available(iOS 13.4, *) {
           datePicker.preferredDatePickerStyle = .wheels
        }
        timePicker.datePickerMode = .time
        customView.timeTextField.inputAccessoryView = toolbar
        customView.timeTextField.inputView = timePicker
    }

    @objc func doneTimePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        customView.timeTextField.text = dateFormatter.string(from: timePicker.date)
        customView.timeTextField.endEditing(true)
    }
}
