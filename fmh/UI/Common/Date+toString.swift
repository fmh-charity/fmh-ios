//
//  Date+toString.swift
//  fmh
//
//  Created: 15.06.2022
//

import Foundation

extension Date {
    
    func toString(_ format: String = "dd.MM.yyy") -> String {
        let formater = DateFormatter()
        formater.dateFormat = format
        return formater.string(from: self)
    }
    
}
