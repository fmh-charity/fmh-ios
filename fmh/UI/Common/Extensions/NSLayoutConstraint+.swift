//
//  NSLayoutConstraint+.swift
//  fmh
//
//  Created: 15.12.2022
//

import UIKit

extension NSLayoutConstraint {
    
    class func activate999(_ constarints: [NSLayoutConstraint]) {
        NSLayoutConstraint.activate(constarints, priority: 999)
    }
    
    class func activate(_ constarints: [NSLayoutConstraint], priority: Float) {
        constarints.forEach {
            if $0.priority.rawValue > priority {
                $0.priority = UILayoutPriority(priority)
            }
        }
        NSLayoutConstraint.activate(constarints)
    }
    
}

