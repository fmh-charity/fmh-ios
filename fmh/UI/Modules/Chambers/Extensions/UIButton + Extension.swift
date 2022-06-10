//
//  UIButton + Extension.swift
//  fmh
//
//  Created: 10.06.2022
//

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
