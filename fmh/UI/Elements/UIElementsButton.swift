//
//  UIElementsButton.swift
//  fmh
//
//  Created: 30.10.2022
//

import UIKit

enum UIElementsButton {
    
    case info(target: Any?, action: Selector, color: UIColor? = nil, isEnabled: Bool = true)
    case settings(target: Any?, action: Selector, color: UIColor? = nil, isEnabled: Bool = true)
    case plus(target: Any?, action: Selector, color: UIColor? = nil, isEnabled: Bool = true)
    case user(target: Any?, action: Selector, color: UIColor? = nil, isEnabled: Bool = true)
    case butterfly(target: Any?, action: Selector, color: UIColor? = nil, isEnabled: Bool = true)
    case status(target: Any?, action: Selector, color: UIColor? = nil, isEnabled: Bool = true)
    case edit(target: Any?, action: Selector, color: UIColor? = nil, isEnabled: Bool = true, isHidden: Bool = false)
    case sorting(target: Any?, action: Selector, color: UIColor? = nil, isEnabled: Bool = true)
    
    var button: UIButton {
        switch self {
        case let .info(target, action, color, isEnabled):
            return makeButton(imageName: "nb.info.circle", target: target, action: action, color: color, isEnabled: isEnabled)
        case let .settings(target, action, color, isEnabled):
            return makeButton(imageName: "nb.settings", target: target, action: action, color: color, isEnabled: isEnabled)
        case let .plus(target, action, color, isEnabled):
            return makeButton(imageName: "nb.plus.circle", target: target, action: action, color: color, isEnabled: isEnabled)
        case let .user(target, action, color, isEnabled):
            return makeButton(imageName: "nb.user", target: target, action: action, color: color, isEnabled: isEnabled)
        case let .butterfly(target, action, color, isEnabled):
            return makeButton(imageName: "nb.butterfly", target: target, action: action, color: color, isEnabled: isEnabled)
        case let .status(target, action, color, isEnabled):
            return makeButton(imageName: "nb.status", target: target, action: action, color: color, isEnabled: isEnabled)
        case let .edit(target, action, color, isEnabled, isHidden):
            return makeButton(imageName: "nb.edit", target: target, action: action, color: color, isEnabled: isEnabled, isHidden: isHidden)
        case let .sorting(target, action, color, isEnabled):
            return makeButton(imageName: "nb.sorting", target: target, action: action, color: color, isEnabled: isEnabled)
            
        }
    }
    
    private func makeButton(imageName: String, target: Any?, action: Selector, color: UIColor? = nil, isEnabled: Bool = true, isHidden: Bool = false) -> UIButton {
        var image = UIImage(named: imageName)
        if let color {
            image = image?.withTintColor(color, renderingMode: .alwaysTemplate)
        }
        let button = UIButton(image: image, target: target, action: action)
        if let color { button.tintColor = color }
        button.isEnabled = isEnabled
        button.isHidden = isHidden
        return button
    }
    
}
