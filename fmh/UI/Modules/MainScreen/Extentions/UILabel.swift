//
//  UILabel.swift
//  TestingProject
//
//  Created by Oleg_Yakovlev on 2.05.22.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont?, alignment: NSTextAlignment = .left) {
        self.init()
      
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = alignment
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
