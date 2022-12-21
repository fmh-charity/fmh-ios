//
//  AddNewsViewController.swift
//  fmh
//
//  Created: 28.05.2022
//

import UIKit

class AddNewsViewController: BaseViewController {
    var idNews: Int?
    var destinationName: String?
    var presenter: AddNewsPresenterProtocol?
    private var categoryValues = ["Объявление", "День рождения", "Зарплата", "Профсоюз", "Праздник", "Массаж", "Благодарность", "Нужна помощь"]
    private var categoryNewsId: Int?
    private var pickerCategory = UIPickerView()
    private var isActiveNews = false

    private var titleNavigation: String?
    private var mainStackView = UIStackView()
    private var dateStackView = UIStackView()
    private var switchStackView = UIStackView()
    private var layoutView = UIView()

    private var switchLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.sizeToFit()
        return label
    }()

    private var categoryTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.placeholder = "Категория    ▼"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = NewsConstants.Collor.borderTF.cgColor
        textField.layer.cornerRadius = 5
        return textField
    }()

    private var titleTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.placeholder = "Заголовок"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = NewsConstants.Collor.borderTF.cgColor
        textField.layer.cornerRadius = 5
        return textField
    }()

    private lazy var switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.contentVerticalAlignment = .center
        switcher.addTarget(self, action: #selector(setActiveNews), for: .valueChanged)
        return switcher
    }()

    private lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Дата публикации"
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.borderColor = NewsConstants.Collor.borderTF.cgColor
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

    private lazy var timeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Время публикации"
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.borderColor = NewsConstants.Collor.borderTF.cgColor
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

    private var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.layer.borderColor = NewsConstants.Collor.borderTF.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5
        return textView
    }()

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
        print(#function)
        self.view.endEditing(true)
        presenter?.createNews(news: createDTONews())
        navigationController?.popViewController(animated: true)
    }

    @objc func cancelAction () {
        print("Cancel Action news")
        self.view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }

//MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
            // TODO: - вынести в отдельный метод или в презентер
        if destinationName == "editNews" {
            titleNavigation = "Редактирование новости"
            guard let id = idNews else { return }
            presenter?.getNews(id: id)
        } else {
            titleNavigation = "Создание новости"
            idNews = 100
        }

        title = titleNavigation
        setBackGround(name: "bacground.main")
        setTextView()
        setCategoryPicker()
        setView()
        setActionForTF()
        setEnabelButtonSave()
        switchLabel.text = switcher.isOn ? "Активна" : "Не активна"

    }

    @objc func setActiveNews (newSwitch: UISwitch) {
        switchLabel.text = newSwitch.isOn ? "Активна" : "Не активна"
    }

    private func getDate(stringDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: stringDate) // replace Date String
    }

    private func createDTONews() -> DTONews{
        let createDate = Date().millisecondsSince1970
        let date = "\(dateTextField.text!)T\(timeTextField.text!):00"
        let publishDate = getDate(stringDate: date)
        let dtoNews = DTONews(
            createDate: createDate,
            creatorId: presenter?.userInfo?.id,
            creatorName: presenter?.userInfo?.firstName,
            description: descriptionTextView.text,
            id: idNews ?? 100,
            newsCategoryId: categoryNewsId ?? 1,
            publishDate: publishDate?.millisecondsSince1970,
            publishEnabled: switcher.isOn,
            title: titleTextField.text ?? "пусто"
        )
        return dtoNews
    }

    private func setActionForTF() {
        categoryTextField.addTarget(self, action: #selector(emptyEditingValid), for: .allEvents)
        titleTextField.addTarget(self, action: #selector(emptyEditingValid), for: .editingChanged)
        dateTextField.addTarget(self, action: #selector(emptyEditingValid), for: .allEvents)
        timeTextField.addTarget(self, action: #selector(emptyEditingValid), for: .allEvents)
    }

    @objc func emptyEditingValid() {
        setEnabelButtonSave()
    }

    private func setEditNewsTextField() {
        let categoryID = presenter?.news?.newsCategoryId
        self.categoryNewsId = categoryID
        categoryTextField.text = presenter?.news?.categoryName
        titleTextField.text = presenter?.news?.title
        dateTextField.text = Date(milliseconds: presenter?.news?.publishDate ?? 0).toString()
        let timeDate = Date(milliseconds: presenter?.news?.publishDate ?? 0)
        let dateFormate = DateFormatter()
        dateFormate.dateStyle = .none
        dateFormate.timeStyle = .short
        dateFormate.dateFormat = "HH:mm"
        timeTextField.text = dateFormate.string(from: timeDate)

        descriptionTextView.text = presenter?.news?.description
        switcher.isOn = presenter?.news?.publishEnabled ?? false
    }

    private func setEnabelButtonSave() {
        let category = categoryTextField.text ?? ""
        let title = titleTextField.text ?? ""
        let datePub = dateTextField.text ?? ""
        let time = timeTextField.text ?? ""
        let description = descriptionTextView.text ?? ""

        saveButton.isEnabled = !category.isEmpty && !title.isEmpty && !datePub.isEmpty && !time.isEmpty && !description.isEmpty
        saveButton.backgroundColor = saveButton.isEnabled ? .accentColor : .gray
    }

    private func setTextView () {
        descriptionTextView.delegate = self
        descriptionTextView.text = "Описание"
        descriptionTextView.textColor = .lightGray
    }

    private func setCategoryPicker() {
        pickerCategory.delegate = self
        pickerCategory.dataSource = self
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

        layoutView = UIView(frame: self.view.bounds.inset(by: UIEdgeInsets(top: self.topBarHeight + 20, left: 16, bottom: self.view.bounds.height / 7, right: 16)))
        layoutView.backgroundColor = .white
        layoutView.layer.cornerRadius = 10
        layoutView.makeShadow()
        self.view.addSubview(layoutView)

        switchStackView = UIStackView(frame: CGRect(origin: .zero, size: CGSize(width: layoutView.bounds.width, height: 60)))
        switchStackView.axis = .horizontal
        switchStackView.alignment = .center
        switchStackView.distribution = .fill
        switchStackView.spacing = 10
        switchStackView.addArrangedSubview(switchLabel)
        switchStackView.addArrangedSubview(switcher)

        dateStackView = UIStackView(frame: CGRect(origin: .zero, size: CGSize(width: layoutView.bounds.width, height: 60)))
        dateStackView.axis = .horizontal
        dateStackView.distribution = .fillEqually
        dateStackView.spacing = 50
        dateStackView.addArrangedSubview(dateTextField)
        dateStackView.addArrangedSubview(timeTextField)

        mainStackView = UIStackView(frame: layoutView.bounds.inset(by: UIEdgeInsets(top: 16, left: 16, bottom: layoutView.bounds.height / 7, right: 16)))
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 30
        mainStackView.addArrangedSubview(categoryTextField)
        mainStackView.addArrangedSubview(titleTextField)
        mainStackView.addArrangedSubview(switchStackView)
        mainStackView.addArrangedSubview(dateStackView)
        mainStackView.addArrangedSubview(descriptionTextView)
        mainStackView.addArrangedSubview(saveButton)
        mainStackView.addArrangedSubview(cancelButton)

        self.layoutView.addSubview(mainStackView)
    }
}

//MARK: - Picker datasource
extension AddNewsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print("numberOfRowsInComponent \(categoryValues.count)")
        return categoryValues.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryValues[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextField.text = categoryValues[row]
        categoryNewsId = row + 1
        print("categoryNewsId \(categoryNewsId)")
        self.view.endEditing(true)
    }
}

//MARK: - extension for textView
extension AddNewsViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == "Описание" && textView.textColor == .lightGray)
        {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder() //Optional
    }

    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = "Описание"
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }

}

extension AddNewsViewController: AddNewsPresenterDelegate {

    func createdNews() {
        navigationController?.popViewController(animated: true)
    }

    func updatedNews() {
        setEditNewsTextField()
        switchLabel.text = switcher.isOn ? "Активна" : "Не активна"
        setEnabelButtonSave()

    }
}
