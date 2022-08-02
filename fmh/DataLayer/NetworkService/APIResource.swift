//
//  APIResource.swift
//  fmh
//
//  Created: 29.04.2022
//

import Foundation

typealias URLParameters = Dictionary<String, String>
typealias HTTPHeaders = Dictionary<String, String>

struct APIResource<Value> where Value: Decodable {

    typealias ResponseType = Value

    var path: String
    var parametrs: URLParameters?
    
    var method: HTTPMethod
    var body: Encodable?
    var headers: HTTPHeaders?
    
    init(path: String, parametrs: URLParameters? = nil, method: HTTPMethod = .get, body: Encodable? = nil, headers: HTTPHeaders? = nil) {
        self.path = path
        self.parametrs = parametrs
        self.method = method
        self.body = body
        self.headers = headers
    }
    
}

