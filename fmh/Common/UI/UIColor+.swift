//
//  UIColor+.swift
//  fmh
//
//  Created: 11.05.2022
//

import UIKit

extension UIColor {

    public class var accentColor: UIColor {
        return UIColor(named: "AccentColor") ?? .init(red: 1/255, green: 161/255, blue: 159/255, alpha: 1.0)
    }
    
}
