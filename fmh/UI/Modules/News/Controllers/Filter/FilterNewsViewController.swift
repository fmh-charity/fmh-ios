//
//  FilterNewsViewController.swift
//  fmh
//
//  Created: 05.06.2022
//

import UIKit

class FilterNewsViewController: UIViewController {
    weak var delegate: NewsListViewControllerDelegate?
    private var categoryId: Int?
    private var datePublish: String? = nil
    //let filters = [FilterNews]()
    
    private var titleView: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .accentColor
        label.textAlignment = .center
        label.text = "Фильтровать новости"
        return label
    }()
    
    private var categoryValues = ["Все", "Объявление", "День рождения", "Зарплата", "Профсоюз", "Праздник", "Массаж", "Благодарность", "Нужна помощь"]
    
    private var pickerCategory = UIPickerView()
    private var mainStackView = UIStackView()
    private var dateStackView = UIStackView()
    private var layoutView = UIView()
    
    private var categoryTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.placeholder = "Категория    ▼"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = ConstantNews.Collor.borderTF.cgColor
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    private var dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Дата публикации"
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.borderColor = ConstantNews.Collor.borderTF.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        let datePicker =  UIDatePicker()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.datePickerMode = .date
        textField.inputView = datePicker
        
        datePicker.addTarget(self, action: #selector(setDate), for: .valueChanged)
        return textField
    }()
    
    @objc func setDate(sender: UIDatePicker) {
        let dateFormate = DateFormatter()
        dateFormate.dateStyle = .medium
        dateFormate.timeStyle = .none
        dateFormate.dateFormat = "dd.MM.yyyy"
        dateTextField.text = dateFormate.string(from: sender.date)
        self.view.endEditing(true)
    }
    
    private var timeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Время публикации"
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.borderColor = ConstantNews.Collor.borderTF.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        
        let datePicker =  UIDatePicker()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "ru_RU")
        
        textField.inputView = datePicker
        
        datePicker.addTarget(self, action: #selector(setTime), for: .valueChanged)
        return textField
    }()
    
    @objc func setTime(sender: UIDatePicker) {
        let dateFormate = DateFormatter()
        dateFormate.dateStyle = .none
        dateFormate.timeStyle = .short
        dateFormate.dateFormat = "HH:mm"
        timeTextField.text = dateFormate.string(from: sender.date)
        self.view.endEditing(true)
    }
    
    
    private var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .accentColor
        button.setTitle("СОХРАНИТЬ", for: .normal)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        return button
    }()
    
    private var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.setTitle("ОТМЕНА", for: .normal)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = ConstantNews.Collor.borderTF.cgColor
        button.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        return button
    }()
    
    @objc func saveAction () {
        print("Save filter news")
        datePublish = dateTextField.text != "" ? dateTextField.text : nil
        let filters = createFilters(categoryId: categoryId, datePublish: datePublish)
        delegate?.filtering(filters: filters)
        self.view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func cancelAction () {
        print("Cancel filter news")
        self.view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackGround(name: "BackGround")
        setCategoryPicker()
        setView()
        
    }
    
    private func createFilters(categoryId: Int?, datePublish: String?) -> [FilterNews?] {
        let filtersCategory = FilterNews.category(categoryId: categoryId)
        let filterDatePublish = FilterNews.datePublish(datePublish: datePublish)
        return [filtersCategory, filterDatePublish]
    }
    
    private func setCategoryPicker() {
        pickerCategory.delegate = self
        pickerCategory.dataSource = self
        pickerCategory.selectRow(4, inComponent: 0, animated: true)
        categoryTextField.inputView = pickerCategory
    }
    
    fileprivate func setBackGround(name: String) {
        let imageViewBackground = UIImageView(image: UIImage(named: name))
        imageViewBackground.contentMode = .scaleToFill
        imageViewBackground.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(imageViewBackground)
        NSLayoutConstraint.activate([
            imageViewBackground.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            imageViewBackground.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageViewBackground.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imageViewBackground.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func setView () {
        layoutView = UIView(frame: self.view.bounds.inset(by: UIEdgeInsets(top: self.topBarHeight + 20, left: 16, bottom: self.view.bounds.height / 4, right: 16)))
        layoutView.backgroundColor = .white
        layoutView.layer.cornerRadius = 10
        layoutView.makeShadow()
        self.view.addSubview(layoutView)
        
        dateStackView = UIStackView(frame: CGRect(origin: .zero, size: CGSize(width: layoutView.bounds.width, height: 60)))
        dateStackView.axis = .horizontal
        dateStackView.distribution = .fillEqually
        dateStackView.spacing = 50
        dateStackView.addArrangedSubview(dateTextField)
        dateStackView.addArrangedSubview(timeTextField)
        
        mainStackView = UIStackView(frame: layoutView.bounds.inset(by: UIEdgeInsets(top: 16, left: 16, bottom: layoutView.bounds.height / 4, right: 16)))
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 30
        mainStackView.addArrangedSubview(titleView)
        mainStackView.addArrangedSubview(categoryTextField)
        mainStackView.addArrangedSubview(dateStackView)
        mainStackView.addArrangedSubview(saveButton)
        mainStackView.addArrangedSubview(cancelButton)
        
        self.layoutView.addSubview(mainStackView)
    }
}

//MARK: - Picker datasource
extension FilterNewsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryValues[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextField.text = categoryValues[row]
        if row != 0 {
            categoryId = row
        }
        self.view.endEditing(true)
    }
    
}

//MARK: - extension for textView placeholder
//extension FilterNewsViewController: UITextViewDelegate {
//    func textViewDidBeginEditing(_ textView: UITextView)
//    {
//        if (textView.text == "Описание" && textView.textColor == .lightGray)
//        {
//            textView.text = ""
//            textView.textColor = .black
//        }
//        textView.becomeFirstResponder() //Optional
//    }
//    
//    func textViewDidEndEditing(_ textView: UITextView)
//    {
//        if (textView.text == "")
//        {
//            textView.text = "Описание"
//            textView.textColor = .lightGray
//        }
//        textView.resignFirstResponder()
//    }
//}


