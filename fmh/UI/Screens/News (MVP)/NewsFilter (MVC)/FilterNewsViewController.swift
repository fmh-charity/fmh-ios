//
//  FilterNewsViewController.swift
//  fmh
//
//  Created: 05.06.2022
//

import UIKit

protocol FilterNewsDelegate: AnyObject {
    func filtering(filter: FilterNews?)
}

class FilterNewsViewController: BaseViewController {

    weak var delegate: FilterNewsDelegate?

    //MARK: - Private properties

    private var categoryId: Int?
    private var fromDatePublish: Date?
    private var toDatePublish: Date?

    private enum DatePublish: Int {
        case dateFrom
        case dateTo
    }

    private lazy var titleView: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .accentColor
        label.textAlignment = .center
        label.text = "Фильтровать новости"
        return label
    }()

    private var categoryValues = ["Все", "Объявление", "День рождения", "Зарплата", "Профсоюз", "Праздник", "Массаж", "Благодарность", "Нужна помощь"]

    private lazy var pickerCategory: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .green
        return picker
    }()

    private var mainStackView = UIStackView()
    private var dateStackView = UIStackView()
    private var layoutView = UIView()

    private lazy var categoryTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.placeholder = "Все категории    ▼"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = NewsConstants.Collor.borderTF.cgColor
        textField.layer.cornerRadius = 5
        return textField
    }()

    private lazy var dateTextFieldFrom: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Дата публикации"
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.borderColor = NewsConstants.Collor.borderTF.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        //textField.tag = DatePublish.dateFrom.rawValue
        let datePicker =  UIDatePicker()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.datePickerMode = .date
        datePicker.tag = DatePublish.dateFrom.rawValue
        textField.inputView = datePicker

        datePicker.addTarget(self, action: #selector(setDate), for: .valueChanged)
        return textField
    }()

    private lazy var dateTextFieldTo: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Дата публикации"
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.borderColor = NewsConstants.Collor.borderTF.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        //textField.tag = DatePublish.dateTo.rawValue
        let datePicker =  UIDatePicker()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }

        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.tag = DatePublish.dateTo.rawValue
        textField.inputView = datePicker

        datePicker.addTarget(self, action: #selector(setDate), for: .valueChanged)
        return textField
    }()

    @objc func setDate(sender: UIDatePicker) {
        let dateFormate = DateFormatter()
        dateFormate.dateStyle = .medium
        dateFormate.timeStyle = .none
        dateFormate.dateFormat = "dd.MM.yyyy"
        switch DatePublish(rawValue: sender.tag) {
        case .dateFrom:
            dateTextFieldFrom.text = dateFormate.string(from: sender.date)
        case .dateTo:
            dateTextFieldTo.text = dateFormate.string(from: sender.date)
        case .none:
            return
        }
        self.view.endEditing(true)
    }

    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .accentColor
        button.setTitle("СОХРАНИТЬ", for: .normal)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        return button
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.setTitle("ОТМЕНА", for: .normal)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = NewsConstants.Collor.borderTF.cgColor
        button.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        return button
    }()

    @objc func saveAction () {
        print("Save filter news")
        fromDatePublish = getDate(stringDate: dateTextFieldFrom.text)
        toDatePublish = getDate(stringDate: dateTextFieldTo.text)
        let filter = FilterNews(newsCategoryId: categoryId, publishDateFrom: fromDatePublish, publishDateTo: toDatePublish)
        delegate?.filtering(filter: filter)
        self.view.endEditing(true)
        self.dismiss(animated: true)
    }

    @objc func cancelAction () {
        self.view.endEditing(true)
        self.dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setBackGround(name: "bacground.main")
        setCategoryPicker()
        setView()

    }

    private func setCategoryPicker() {
        pickerCategory.delegate = self
        pickerCategory.dataSource = self
        pickerCategory.selectRow(4, inComponent: 0, animated: true)
        categoryTextField.inputView = pickerCategory
    }

    private func getDate(stringDate: String?) -> Date? {
        guard let stringDate else {return nil}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: stringDate)
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
        dateStackView.addArrangedSubview(dateTextFieldFrom)
        dateStackView.addArrangedSubview(dateTextFieldTo)

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
        categoryId = row
    }
}
