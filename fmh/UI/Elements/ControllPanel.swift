//
//  ControllPanel.swift
//  fmh
//
//  Created: 30.10.2022
//

import UIKit

class ControllPanel: UIView {
    
    // TODO: Потом необходимо размер кнопок добавить если такие не устроят.
    var buttons: [UIButton] = []
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    lazy var stackButtons: UIStackView = {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .clear
        stack.distribution = .equalSpacing
        stack.axis = .horizontal
        stack.alignment = .center
//        stack.spacing = 14
        return stack
    }()
    
    init(title: String, buttons: [UIButton]) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1)
        
        self.titleLabel.text = title
        self.buttons = buttons
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        let stackWidth = buttons.count * 34 // <- Не удалось укратить мне приоритеты лайаута UIStackView :)))
        
        addSubviews([titleLabel, stackButtons])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            stackButtons.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            stackButtons.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            stackButtons.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            stackButtons.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackButtons.widthAnchor.constraint(equalToConstant: CGFloat(stackWidth))
        ])
    }

}
