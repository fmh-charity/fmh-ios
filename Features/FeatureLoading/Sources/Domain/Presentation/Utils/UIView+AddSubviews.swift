//
//  UIView+AddSubviews+.swift
//  
//
//  Created: 05.08.2023
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView..., constraints: () -> ([NSLayoutConstraint])) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        NSLayoutConstraint.activate(constraints())
    }
}
