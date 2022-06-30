//
//  UILabel + Extension.swift
//  fmh
//
//  Created: 30.06.2022
//

import UIKit

extension UILabel {
    
    convenience init(textColor: UIColor?, font: UIFont?, numberOfLines: Int = 0) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = textColor
        self.font = font
        self.numberOfLines = numberOfLines
    }
    
}
