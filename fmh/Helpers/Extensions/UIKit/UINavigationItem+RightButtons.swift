//
//  UI.UINavigationItem+RightButtons.swift
//  fmh
//
//  Created: 13.12.2022
//

import UIKit

// MARK:  - КНОПКИ ДЛЯ ПРАВОЙ СТОРОНЫ NAVIGATIONITEM -

extension UINavigationItem {
    
    func setRightBarButtonItems(buttons: [UIButton]) {
        let stackView = UIStackView.init(arrangedSubviews: buttons)
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 14
        stackView.distribution = .fill
        
        let buttonsStack = UIBarButtonItem(customView: stackView)
        self.rightBarButtonItems = [buttonsStack]
    }
}
