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
    
    init(method: HTTPMethod = .GET, path: String, query: HTTPQuery? = nil, headers: HTTPHeaders? = nil, body: HTTPBody? = nil) throws {
        
        let baseUrl = Helper.Core.Plist.getValueDictionary(forResource: "AppSettings", forKey: "API_host")
        guard let baseURL = baseUrl as? String, var urlComponents = URLComponents(string: baseURL) else {
            throw NSError(domain: "URLRequest.Init", code: 1001)
        }
        
        urlComponents.path = path
        urlComponents.queryItems = query?.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponents.url else {
            throw NSError(domain: "URLRequest.Init", code: 1002)
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
