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
    
    public struct topControl {
        public static var backGround: UIColor {
            return UIColor(red: 0.917, green: 0.917, blue: 0.917, alpha: 1)
        }
        public static var title: UIColor {
            return UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
        public static var item: UIColor {
            return UIColor(red: 0.439, green: 0.439, blue: 0.439, alpha: 1)
        }
    }
    
}
