//
//  PasswordTextfield.swift
//  fmh
//
//  Created: 02.05.2022
//

import UIKit

class PasswordTextfield: UITextField {

    var isInvalid: Bool = false {
        didSet {
            if !isInvalid {
                leftImageView.tintColor = .lightGray
            } else {
                leftImageView.tintColor = .red
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit ()
    }
 
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit ()
    }
    
    // MARK: - Private functions
    private func commonInit () {
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 5.0
        backgroundColor = .white
        
        textContentType = .password
        autocapitalizationType = .none
        autocorrectionType = .no
        keyboardType = .default
        returnKeyType = .done
        isSecureTextEntry = true
        placeholder = "Пароль"
        
        leftView = leftImageView
        leftViewMode = .always
        
        rightView = rightButtonView
        rightViewMode = .always
        
        rightButtonView.addTarget(self, action: #selector(toggleSecure), for: .touchUpInside)
        
    }
    
    private var isSecure: Bool = true {
        didSet {
            isSecureTextEntry = isSecure
            if isSecure {
                rightButtonView.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            } else {
                rightButtonView.setImage(UIImage(systemName: "eye"), for: .normal)
            }
        }
    }
    
    @objc private func toggleSecure() {
        isSecure.toggle()
    }
    
    // MARK: - Elements
    private var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .lightGray
        imageView.image = UIImage(systemName: "lock")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()

    private var rightButtonView: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .lightGray
        let image = UIImage(systemName: "eye.slash")
        button.setImage(image, for: .normal)
        
        return button
    }()
    
    // MARK: - override functions
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.leftViewRect(forBounds: bounds)
        return rect.inset(by: .init(top: 0, left: bounds.height/2, bottom: 0, right: 0))
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.rightViewRect(forBounds: bounds)
        return rect.inset(by: .init(top: 0, left: -bounds.height/2, bottom: 0, right: 0))
    }


    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: .init(top: 0, left: bounds.height/2, bottom: 0, right: 0))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: .init(top: 0, left: bounds.height/2, bottom: 0, right: 0))
    }
    
}
