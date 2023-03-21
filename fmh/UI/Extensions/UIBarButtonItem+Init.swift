//
//  UI.UIBarButtonItem.swift
//  fmh
//
//  Created: 13.12.2022
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(type: UIButton._ButtonType, style: UIBarButtonItem.Style = .done, target: Any?, action: Selector, color: UIColor? = nil) {
        var img = type.img
        if let color {
            img  = img?.withTintColor(color, renderingMode: .alwaysTemplate)
        }
        self.init(image: img, style: style, target: target, action: action)
        if let color { self.tintColor = color }
    }
}
