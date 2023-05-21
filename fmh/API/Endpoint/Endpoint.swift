//
//  Endpoint.swift
//  fmh
//
//  Created: 21.05.2023
//

import Foundation

struct Endpoint<T>: EndpointProtocol {
    
    typealias Model = T
    
    let method: HTTPMethod
    let path: String
    let query: HTTPQuery?
    let headers: HTTPHeaders?
    let body: HTTPBody?
    
    init(method: HTTPMethod = .GET, path: String, query: HTTPQuery? = nil, headers: HTTPHeaders? = nil, body: HTTPBody? = nil) {
        self.method = method
        self.path = path
        self.query = query
        self.headers = headers
        self.body = body
    }
}
