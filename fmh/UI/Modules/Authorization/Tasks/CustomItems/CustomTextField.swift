//
//  CustomTextField.swift
//  fmh
//
//  Created: 02.06.2022
//

import UIKit

extension UITextField {
    convenience init(placeholder: String) {
        self.init(frame: CGRect())
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.setLeftPaddingPoints(10)
        self.font = UIFont.systemFont(ofSize: 15)
        self.placeholder = placeholder
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderColor = UIColor.gray.cgColor
    }

    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

