//
//  UI.UINavigationItem+rightButtons.swift
//  fmh
//
//  Created: 13.12.2022
//

import UIKit

//MARK:  - КНОПКИ ДЛЯ ПРАВОЙ СТОРОНЫ NAVIGATIONITEM -

extension UINavigationItem {
    
    func setRightBarButtonItems(buttons: [UIButton]) {
        let stackview = UIStackView.init(arrangedSubviews: buttons)
        stackview.distribution = .equalSpacing
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.spacing = 14
        stackview.distribution = .fill
        
        let buttonsStack = UIBarButtonItem(customView: stackview)
        self.rightBarButtonItems = [buttonsStack]
    }
    
}
