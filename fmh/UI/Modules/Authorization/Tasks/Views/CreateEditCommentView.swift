//
//  CreateEditCommentView.swift
//  fmh
//
//  Created: 8.06.22
//

import UIKit

class CreateEditCommentView: UIView {
    var commentTextField = UITextField(placeholder: "Комментарий")
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "описание"
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }()
    
    var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.layer.cornerRadius = 7
        button.backgroundColor = UIColor(named: "AccentColor")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var cancelButton: UIButton = {
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
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        let buttonsStack = UIStackView(views: [commentTextField, saveButton, cancelButton], axis: .vertical, spacing: 10, alignment: .fill, distribution: .fillEqually)
        addSubview(buttonsStack)
        addSubview(commentLabel)
        
        NSLayoutConstraint.activate([
            buttonsStack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            buttonsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            buttonsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            buttonsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
    
            commentLabel.topAnchor.constraint(equalTo: commentTextField.topAnchor, constant: -7),
            commentLabel.leadingAnchor.constraint(equalTo: commentTextField.leadingAnchor, constant: 10),
            commentLabel.widthAnchor.constraint(equalToConstant: 75),
            commentLabel.heightAnchor.constraint(equalToConstant: 15),
])
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}
