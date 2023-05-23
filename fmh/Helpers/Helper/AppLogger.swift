//
//  AppLogger.swift
//  fmh
//
//  Created: 14.03.2023
//

import Foundation

enum AppLogger {
    
    private enum MessageType { case debug }
    
    private static let executableTypes: [MessageType] = [.debug]
}

// MARK: - Debug message

extension AppLogger {
    
    static func debug(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        guard executableTypes.contains(.debug) else { return }
        #if DEBUG
            Swift.print(items, separator: separator, terminator: terminator)
        #endif
    }
}
