//
//  Logger.swift
//  fmh
//
//  Created: 14.03.2023
//

import Foundation

typealias Logger = Helper.Core.Logger

extension Helper.Core {
    
    enum Logger {
        
        private enum MessageType { case debug }
        
        private static let executableTypes: [MessageType] = [.debug]
    }
}

// MARK: - Debug message

extension Helper.Core.Logger {
    
    static func debug(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        guard executableTypes.contains(.debug) else { return }
        #if DEBUG
            Swift.print(items, separator: separator, terminator: terminator)
        #endif
    }
}
