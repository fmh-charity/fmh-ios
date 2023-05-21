//
//  APIClientProtocol.swift
//  fmh
//
//  Created: 16.05.2023
//

import Foundation

protocol APIClientProtocol {
    func checkAuthentication() async -> Bool
    func login(login: String, password: String) async throws
    func logout() async
    func fetch(for request: URLRequest?, isRetryIfUnauthorized: Bool) async throws -> (Data, URLResponse)
    func fetch<T: EndpointProtocol>(with endpoint: T, isRetryIfUnauthorized: Bool) async throws -> T.Model where T.Model: Decodable
    func fetch<T: EndpointProtocol>(with endpoint: T, isRetryIfUnauthorized: Bool) async throws where T.Model == Never
}

// MARK: - Default

extension APIClientProtocol {
    
    func fetch(for request: URLRequest?) async throws -> (Data, URLResponse) {
        try await fetch(for: request, isRetryIfUnauthorized: true)
    }
    
    func fetch<T: EndpointProtocol>(with endpoint: T) async throws -> T.Model where T.Model: Decodable {
        try await fetch(with: endpoint, isRetryIfUnauthorized: true)
    }
    
    func fetch<T: EndpointProtocol>(with endpoint: T) async throws where T.Model == Never {
        try await fetch(with: endpoint, isRetryIfUnauthorized: true)
    }
}
