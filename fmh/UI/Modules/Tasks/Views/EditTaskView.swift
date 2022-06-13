//
//  EditTaskView.swift
//  fmh
//
//  Created: 03.06.2022
//

import UIKit

final class EditTaskView: UIView {
    
    let themeTextField = UITextField(placeholder: "Тема*")
    let executorTextField = UITextField(placeholder: "Исполнитель*")
    let dateTextField = UITextField(placeholder: "Дата*")
    let timeTextField = UITextField(placeholder: "Время")
    let descriptionTextField = UITextField(placeholder: "Описание")
    let pickerView = UIPickerView()
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    let names = ["asdsad", "asd21312sad","виталик","qweqw","asdsad","asdsad",]
    
    private let themeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "тема"
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "описание"
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "дата"
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "время"
        label.textAlignment = .left
        label.backgroundColor = .white
        return label
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.layer.cornerRadius = 7
        button.backgroundColor = UIColor(named: "AccentColor")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor( UIColor.gray, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 7
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setUpPickers()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpPickers() {
        let frame1 = CGRect(x: 0, y: 0, width: self.bounds.width, height: 200)
        datePicker.frame =  frame1
        timePicker.frame = frame1
        self.executorTextField.delegate = self
        pickerView.dataSource = self
        pickerView.delegate = self
        self.executorTextField.inputView = pickerView
        createDatePicker()
        createTimePicker()
    }
    
    private func setupConstraints() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.lightGray.cgColor
        let dateAndTimeStack = UIStackView(views: [dateTextField, timeTextField], axis: .horizontal, spacing: 10, alignment: .fill, distribution: .fillEqually)
        let buttonsStack = UIStackView(views: [saveButton, cancelButton], axis: .vertical, spacing: 10, alignment: .fill, distribution: .fillEqually)
        let ownStack = UIStackView(views: [themeTextField, executorTextField, dateAndTimeStack, descriptionTextField], axis: .vertical, spacing: 30, alignment: .fill, distribution: .fillEqually)
        
        addSubview(buttonsStack)
        addSubview(ownStack)
        addSubview(themeLabel)
        addSubview(descriptionLabel)
        addSubview(dateLabel)
        addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            ownStack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            ownStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            ownStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            ownStack.bottomAnchor.constraint(equalTo: buttonsStack.topAnchor, constant: -30),
            
            buttonsStack.topAnchor.constraint(equalTo: ownStack.bottomAnchor, constant: 30),
            buttonsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            buttonsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            buttonsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            buttonsStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            
            themeLabel.topAnchor.constraint(equalTo: themeTextField.topAnchor, constant: -7),
            themeLabel.leadingAnchor.constraint(equalTo: themeTextField.leadingAnchor, constant: 10),
            themeLabel.widthAnchor.constraint(equalToConstant: 50),
            themeLabel.heightAnchor.constraint(equalToConstant: 15),
            
            descriptionLabel.topAnchor.constraint(equalTo: descriptionTextField.topAnchor, constant: -7),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionTextField.leadingAnchor, constant: 10),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 75),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 15),
            
            dateLabel.topAnchor.constraint(equalTo: dateTextField.topAnchor, constant: -7),
            dateLabel.leadingAnchor.constraint(equalTo: dateTextField.leadingAnchor, constant: 10),
            dateLabel.widthAnchor.constraint(equalToConstant: 50),
            dateLabel.heightAnchor.constraint(equalToConstant: 15),
            
            timeLabel.topAnchor.constraint(equalTo: timeTextField.topAnchor, constant: -7),
            timeLabel.leadingAnchor.constraint(equalTo: timeTextField.leadingAnchor, constant: 10),
            timeLabel.widthAnchor.constraint(equalToConstant: 50),
            timeLabel.heightAnchor.constraint(equalToConstant: 15),
        ])
    }
}

extension EditTaskView: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
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
        self.executorTextField.text = names[row]
        self.executorTextField.endEditing(true)
    }
}

extension EditTaskView {
    func createDatePicker() {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: self.bounds.width, height: 50)))
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: nil,
                                         action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.datePickerMode = .date
        self.dateTextField.inputAccessoryView = toolbar
        self.dateTextField.inputView = datePicker
    }
    
    @objc func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        self.dateTextField.text = dateFormatter.string(from: datePicker.date)
        self.dateTextField.endEditing(true)
    }
}

extension EditTaskView {
    func createTimePicker() {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: self.bounds.width, height: 50)))
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: nil,
                                         action: #selector(doneTimePressed))
        toolbar.setItems([doneButton], animated: true)
        if #available(iOS 13.4, *) {
            timePicker.preferredDatePickerStyle = .wheels
        }
        timePicker.datePickerMode = .time
        self.timeTextField.inputAccessoryView = toolbar
        self.timeTextField.inputView = timePicker
    }
    
    @objc func doneTimePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .medium
        dateFormatter.dateFormat = "hh:mm"
        self.timeTextField.text = dateFormatter.string(from: timePicker.date)
        self.timeTextField.endEditing(true)
    }
}
