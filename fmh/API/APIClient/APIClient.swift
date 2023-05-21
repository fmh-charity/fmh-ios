//
//  APIClient.swift
//  fmh
//
//  Created: 16.05.2023
//

import Foundation

final class APIClient {
    
    private let service: APIService
    private let tokenProvider: TokenProviderProtocol
    
    init(service: APIService, tokenProvider: TokenProviderProtocol) {
        self.service = service
        self.tokenProvider = tokenProvider
    }
    
    private func interceptorRequest(for request: URLRequest?, isWithToken: Bool) async throws -> URLRequest {
        
        guard var request = request else {
            throw APIClientError.urlRequestNil
        }
        
        if isWithToken {
            let token = try await tokenProvider.getAccessToken()
            request.setValue("\(token)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
    
    private func refreshToken() async throws {
        
        let refreshToken = try await tokenProvider.getRefreshToken()
        
        let request = try AuthenticationEndpoint.refresh(refreshToken: refreshToken).urlRequest()
        
        let response = try await service.data(for: request)
        let tokens: DTOJWT = try response.0.decode()
        
        await tokenProvider.setTokens(accessToken: tokens.accessToken, refreshToken: tokens.refreshToken)
    }
}

// MARK: - APIClientProtocol

extension APIClient: APIClientProtocol {
    
    func checkAuthentication() async -> Bool {
        let isOkToken = try? await tokenProvider.getAccessToken()
        return isOkToken != nil ? true : false
    }
    
    func login(login: String, password: String) async throws {
        
        let request = try AuthenticationEndpoint.login(login: login, password: password).urlRequest()
        
        let response = try await service.data(for: request)
        let tokens: DTOJWT = try response.0.decode()
        
        await tokenProvider.setTokens(accessToken: tokens.accessToken, refreshToken: tokens.refreshToken)
    }
    
    func logout() async {
        await tokenProvider.setTokens(accessToken: nil, refreshToken: nil)
    }
    
    // base
    
    func fetch(for request: URLRequest?, isRetryIfUnauthorized: Bool) async throws -> (Data, URLResponse) {
        
        let request = try await interceptorRequest(for: request, isWithToken: true)
        
        do {
            return try await service.data(for: request)
        } catch {
            
            guard isRetryIfUnauthorized,
                  case .responseError(let code, _) = error as? APIServiceError,
                  code == 401
            else { throw error }
            
            try await self.refreshToken()
            return try await self.fetch(for: request, isRetryIfUnauthorized: false)
        }
    }
    
    // with generic
    
    func fetch<T: EndpointProtocol>(with endpoint: T, isRetryIfUnauthorized: Bool) async throws -> T.Model where T.Model: Decodable {
        
        let request = try endpoint.urlRequest()
        let (data, _) = try await self.fetch(for: request, isRetryIfUnauthorized: isRetryIfUnauthorized)
        
        return try data.decode()
    }
    
    func fetch<T: EndpointProtocol>(with endpoint: T, isRetryIfUnauthorized: Bool) async throws where T.Model == Never {
        
        let request = try endpoint.urlRequest()
        let (_, _) = try await self.fetch(for: request, isRetryIfUnauthorized: isRetryIfUnauthorized)
    }
}
