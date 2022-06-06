//
//  ButtonsExtension.swift
//  fmh
//
//  Created: 28.05.2022
//

import Foundation
import UIKit

extension UIButton {
    convenience init(image: UIImage?) {
        self.init(type: .system)
        self.backgroundColor = .clear
        self.tintColor = .gray
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .scaleAspectFit
        self.setImage(image, for: .normal)
    }
}


extension UILabel {
    convenience init(text: String?, font: UIFont?, tintColor: UIColor, textAlignment: NSTextAlignment) {
        self.init(frame: CGRect())
        self.text = text
        self.font = font
        self.tintColor = tintColor
        self.textColor = tintColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = textAlignment
        self.backgroundColor = .clear
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 0
    }
}

//extension UIStackView {
//    convenience init(axis: NSLayoutConstraint.Axis, spacing: CGFloat = 0.0, alignment: UIStackView.Alignment = .fill) {
//        self.axis = axis
//        self.spacing = spacing
//        self.alignment = alignment
//        self.distribution = distribution
//        self.translatesAutoresizingMaskIntoConstraints = false
//    }
//}
//
