//
//  APIService.swift
//  fmh
//
//  Created: 20.05.2023
//

import Foundation

class APIService {
    
    let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    private func interceptor(with response: (Data, URLResponse)) async throws -> (Data, URLResponse){
        
        guard let urlResponse = response.1 as? HTTPURLResponse else {
            return response
        }
        
        if (200...299) ~= urlResponse.statusCode {
            return response
        }
        
        // If bad statusCode ...
        
        var description = "Answer is not equal code to 200...299. Code: \(urlResponse.statusCode)"
        if let dictionaryError = try? response.0.jsonObject() as? [String: Any] {
            
            // TODO: Проверить возможно violations словарь !
            
            description = dictionaryError["message"] as? String ?? ""
        }
        
        throw APIServiceError.responseError(urlResponse.statusCode, description)
    }
}

// MARK: - APIServiceProtocol

extension APIService: APIServiceProtocol {
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        
        let response = try await urlSession.data(for: request)
        
        let logItems: [Any?] = [(response.1 as? HTTPURLResponse)?.statusCode, request.cURL(pretty: true)]
        Logger.debug(logItems.compactMap { $0 })
        
        return try await interceptor(with: response)
    }
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        
        let response = try await urlSession.data(from: url)
        
        let logItems: [Any?] = [(response.1 as? HTTPURLResponse)?.statusCode, url]
        Logger.debug(logItems.compactMap { $0 })
        
        return try await interceptor(with: response)
    }
}
