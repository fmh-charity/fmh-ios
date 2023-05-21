//
//  EndpointProtocol.swift
//  fmh
//
//  Created: 21.05.2023
//

import Foundation

typealias HTTPQuery = [String : String?]
typealias HTTPBody = Data
typealias HTTPHeaders = [String : String]

protocol EndpointProtocol {
    
    associatedtype Model
    
    var host: String? { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var query: HTTPQuery? { get }
    var headers: HTTPHeaders? { get }
    var body: HTTPBody? { get }
}

// MARK: - Default params

extension EndpointProtocol {
    
    var host: String? {
        Plist.getSettingsValue(keyPath: "API.host") as? String
    }
}

// MARK: - Make URL

extension EndpointProtocol {
    
    func url() throws -> URL {
        
        let host = self.host
        
        guard let host = host, var urlComponents = URLComponents(string: host) else {
            throw EndpointProtocolError.invalidHost(String(describing: host))
        }
        
        urlComponents.path = self.path
        urlComponents.queryItems = self.query?.map {
            URLQueryItem(name: $0.key, value: $0.value?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
        }
        
        guard let url = urlComponents.url else {
            throw EndpointProtocolError.invalidUrl
        }
        
        return url
    }
}

// MARK: - Make URLRequest

extension EndpointProtocol {
    
    func urlRequest() throws -> URLRequest {
        
        let url = try self.url()
        
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        
        if let body = self.body {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = body
        }
        
        self.headers?.forEach { request.addValue($0, forHTTPHeaderField: $1) }
        
        return request
    }
}
