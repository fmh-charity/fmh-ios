//
//  EndpointProtocolError.swift
//  fmh
//
//  Created: 21.05.2023
//

import Foundation

enum EndpointProtocolError: Error {
    case invalidHost(_ host: String)
    case invalidUrl
}

// MARK: - LocalizedError

extension EndpointProtocolError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .invalidHost(let host):    return "URLComponents not initialize: host = \(host)"
        case .invalidUrl:               return "URLComponents.url not initialize."
        }
    }
}
