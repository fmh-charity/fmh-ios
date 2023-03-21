//
//  NSLayoutConstraint+Activate.swift
//  fmh
//
//  Created: 15.12.2022
//

import UIKit

extension NSLayoutConstraint {
    
    class func activate999(_ constraints: [NSLayoutConstraint]) {
        NSLayoutConstraint.activate(constraints, priority: 999)
    }
    
    class func activate(_ constraints: [NSLayoutConstraint], priority: Float) {
        constraints.forEach {
            if $0.priority.rawValue > priority {
                $0.priority = UILayoutPriority(priority)
            }
        }
        NSLayoutConstraint.activate(constraints)
    }
}

