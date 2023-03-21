//
//  UIButton+Buttons.swift
//  fmh
//
//  Created: 13.12.2022
//

import UIKit

extension UIButton {
    
    convenience init(image: UIImage?, target: Any?, action: Selector) {
        self.init(type: .custom)
        setImage(image, for: .normal)
        addTarget(target, action: action, for: .touchUpInside)
    }
}

// MARK: - Prepared buttons ...

extension UIButton {
    
    convenience init(type: _ButtonType, target: Any?, action: Selector, color: UIColor? = nil) {
        var img = type.img
        if let color {
            img  = img?.withTintColor(color, renderingMode: .alwaysTemplate)
        }
        self.init(image: type.img, target: target, action: action)
        if let color { self.tintColor = color }
    }
    
    enum _ButtonType {
        // NavigationBar
        case info, settings, plus, user, butterfly, status, edit, sorting
        // Other
        case menu
        
        var img: UIImage? {
            switch self {
            case .info: return        UIImage(named: "nb.info.circle")
            case .settings: return    UIImage(named: "nb.settings")
            case .plus: return        UIImage(named: "nb.plus.circle")
            case .user: return        UIImage(named: "nb.user")
            case .butterfly: return   UIImage(named: "nb.butterfly")
            case .status: return      UIImage(named: "nb.status")
            case .edit: return        UIImage(named: "nb.edit")
            case .sorting: return     UIImage(named: "nb.sorting")
                
            case .menu: return       UIImage(systemName: "list.bullet")
            }
        }
    }
}
