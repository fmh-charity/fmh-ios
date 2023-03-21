//
//  UIView+AddSubviews.swift
//  fmh
//
//  Created: 11.12.2022
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
