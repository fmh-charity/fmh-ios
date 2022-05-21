//
//  LoginTextfield.swift
//  fmh
//
//  Created: 02.05.2022
//

import UIKit

class LoginTextfield: UITextField {

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
        
        textContentType = .username
        autocapitalizationType = .none
        autocorrectionType = .no
        keyboardType = .default
        returnKeyType = .next
        placeholder = "userName@mail.ru"
        
        leftView = leftImageView
        leftViewMode = .always
  
    }
    
    // MARK: - Elements
    lazy private var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .lightGray
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    // MARK: - override functions
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.leftViewRect(forBounds: bounds)
        return rect.inset(by: .init(top: 0, left: bounds.height/2, bottom: 0, right: 0))
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
