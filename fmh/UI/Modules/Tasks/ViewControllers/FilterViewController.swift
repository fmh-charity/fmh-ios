//
//  FilterViewController.swift
//  fmh
//
//  Created: 14.06.22
//

import UIKit



final class FilterViewController: UIViewController {
    var filterComplition: ((Dictionary<String,Bool>) -> ())?
    private var buttonCases: Dictionary<String,Bool> = ["Open":false, "Work":false, "Completed":false, "Canceled":false]
    private let mainLabel = UILabel(text: "Фильтровать",
                                    font: UIFont.systemFont(ofSize: 25),
                                    tintColor: UIColor(named: "AccentColor") ?? .black,
                                    textAlignment: .left)
    
    private let isOpenLabel = UILabel(text: "Открыта",
                                      font: UIFont.systemFont(ofSize: 15),
                                      tintColor: .black,
                                      textAlignment: .left)
    
    private let inWorkLabel = UILabel(text: "В работе",
                                      font: UIFont.systemFont(ofSize: 15),
                                      tintColor: .black,
                                      textAlignment: .left)
    
    private let isCompletedLabel = UILabel(text: "Выполнена",
                                           font: UIFont.systemFont(ofSize: 15),
                                           tintColor: .black,
                                           textAlignment: .left)
    
    private let isCanceledLabel = UILabel(text: "Отменена",
                                          font: UIFont.systemFont(ofSize: 15),
                                          tintColor: .black,
                                          textAlignment: .left)
    
    private let isOpenCheckButton: UIButton = {
        let button = UIButton()
        button.tag = 0
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let inWorkCheckButton: UIButton = {
        let button = UIButton()
        button.tag = 1
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let isCompletedCheckButton: UIButton = {
        let button = UIButton()
        button.tag = 2
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let isCanceledCheckButton: UIButton = {
        let button = UIButton()
        button.tag = 3
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отмена", for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.setTitleColor(UIColor.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let okButton: UIButton = {
        let button = UIButton()
        button.setTitle("ОК", for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        view.backgroundColor = .white
    }
    
    func setupElements() {
        view.addSubview(mainLabel)
        let labelStackView = UIStackView(views: [isOpenLabel, inWorkLabel, isCompletedLabel, isCanceledLabel, cancelButton], axis: .vertical, spacing: 15, alignment: .fill, distribution: .fillEqually)
        let buttonsStackView = UIStackView(views: [isOpenCheckButton, inWorkCheckButton, isCompletedCheckButton, isCanceledCheckButton, okButton], axis: .vertical, spacing: 15, alignment: .fill, distribution: .fillEqually)
        let ownStack = UIStackView(views: [labelStackView, buttonsStackView], axis: .horizontal, spacing: 35, alignment: .fill, distribution: .fillEqually)
        isOpenCheckButton.addTarget(self, action: #selector(checkedButtons(_:)), for: .touchUpInside)
        inWorkCheckButton.addTarget(self, action: #selector(checkedButtons(_:)), for: .touchUpInside)
        isCompletedCheckButton.addTarget(self, action: #selector(checkedButtons(_:)), for: .touchUpInside)
        isCanceledCheckButton.addTarget(self, action: #selector(checkedButtons(_:)), for: .touchUpInside)
        okButton.addTarget(self, action: #selector(okButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(ownStack)
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.bottomAnchor.constraint(equalTo: ownStack.topAnchor, constant: -20),
            
            ownStack.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 20),
            ownStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            ownStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            ownStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    
    @objc func checkedButtons(_ sender:UIButton){
        switch sender.tag
        {
        case 0: buttonCases["Open"] = buttonCases["Open"] == false ? true : false
            print(self.filterComplition?(buttonCases))
            break
        case 1: buttonCases["Work"] = buttonCases["Work"] == false ? true : false
            break
        case 2: buttonCases["Completed"] = buttonCases["Completed"] == false ? true : false
            break
        case 3: buttonCases["Canceled"] = buttonCases["Canceled"] == false ? true : false
            
        default: print("Other...")
        }
        sender.setImage(UIImage(systemName: sender.currentImage == UIImage(systemName: "square") ? "checkmark.square" : "square"), for: .normal)
    }
    
    @objc func okButtonTapped(_ sender:UIButton){
        filterComplition?(buttonCases)
        print(buttonCases)
        print(self.filterComplition?(buttonCases))
        
        
        dismiss(animated: true)
        
   
    }
    func testfunc(complition: @escaping (Dictionary<String,Bool>) -> ()){
        complition(buttonCases)
    }
}
