//
//  Logger.swift
//  fmh
//
//  Created: 14.03.2023
//

import Foundation

enum Logger {
    
}

// MARK: - Print

extension Logger {
    
    static func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        #if DEBUG
            Swift.print(items, separator: separator, terminator: terminator)
        #endif
    }
}

