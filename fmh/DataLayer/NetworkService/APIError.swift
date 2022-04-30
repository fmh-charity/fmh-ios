//
//  APIError.swift
//  fmh
//
//  Created: 29.04.2022
//

import Foundation

enum APIError: Error {
    
    case invalidURL
    case URLRequestError(Error)
    case JSONDecoderError(Error)
    case HTTPURLResponse(statusCode: Int, description: String)
    
}


// MARK: - Discription error
extension APIError {
    
    var description: String {
        switch self {
        case .URLRequestError(let error), .JSONDecoderError(let error):
            return error.localizedDescription
        case .HTTPURLResponse(_ , let description):
            return description
        case .invalidURL:
            return "Invalid URL"
        }
    }
    
}
