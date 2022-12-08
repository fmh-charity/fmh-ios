//
//  URLRequest.swift
//  fmh
//
//  Created: 01.12.2022
//

import Foundation

enum HTTPMethod: String {
    case GET = "GET", POST = "POST", PUT = "PUT", DELETE = "DELETE"
}

typealias HTTPQuery = [String : String?]
typealias HTTPBody = Data // [String : Any]
typealias HTTPHeaders = [String : String]

extension URLRequest {
    
    init(_ method: HTTPMethod = .GET, path: String, query: HTTPQuery? = nil, headers: HTTPHeaders? = nil, body: HTTPBody? = nil) throws {
        
        let baseUrl = Helper.Core.Plist.getValueDictionary(forResource: "AppSettings", forKey: "API_host")
        guard let baseURL = baseUrl as? String, var urlComponents = URLComponents(string: baseURL) else {
            let _error = NSError(domain: "URLRequest.URLComponents.init", code: 1001, userInfo: [
                NSLocalizedDescriptionKey : "URLComponents not initialize: baseUrl=\(String(describing: baseUrl))"
            ])
            throw _error
        }
        
        urlComponents.path = path
        urlComponents.queryItems = query?.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponents.url else {
            let _error = NSError(domain: "URLRequest.URLComponents.url", code: 1002, userInfo: [
                NSLocalizedDescriptionKey : "URLComponents.url not initialize."
            ])
            throw _error
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        ["application/json" : "Content-Type"].forEach {
            request.addValue($0, forHTTPHeaderField: $1)
        }
        
        headers?.forEach { request.addValue($0, forHTTPHeaderField: $1) }
        
        self = request
        
    }
    
}
