//
//  APIResource.swift
//  fmh
//
//  Created: 29.04.2022
//

import Foundation

struct APIResource<Value> where Value: Decodable {

    public typealias ResponseType = Value

    public var path: String
    public var parametrs: URLParameters?
    
    public var method: HTTPMethod
    public var body: Encodable?
    public var headers: HTTPHeaders?
    
    init(path: String, parametrs: URLParameters? = nil, method: HTTPMethod = .get, body: Encodable? = nil, headers: HTTPHeaders? = nil) {
        self.path = path
        self.parametrs = parametrs
        self.method = method
        self.body = body
        self.headers = headers
    }
    
}

