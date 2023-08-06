//
//  NetworkingProvider.swift
//  fmh
//
//  Created: 30.07.2023
//

import Foundation
import Core

final class NetworkingProvider {

    private let host: String
    private let urlSession: URLSession
    private let analyticsTracking: AnalyticsTracking

    init(host: String, urlSession: URLSession, analyticsTracking: AnalyticsTracking) {
        self.host = host
        self.urlSession = urlSession
        self.analyticsTracking = analyticsTracking
    }
}

// MARK: - Networking

extension NetworkingProvider: Networking {

    func perform(for endpoint: Core.Endpoint) async throws -> (Data, URLResponse) {
        let urlRequest = try endpoint.makeURLRequest(host: host)

        let response = try await urlSession.data(for: urlRequest)

        analyticsTracking.track(
            event: "NetworkingProvider.perform",
            properties: [
                "statusCode": (response.1 as? HTTPURLResponse)?.statusCode ?? "",
                "url": (response.1 as? HTTPURLResponse)?.url ?? ""
            ]
        )

        return try await responseHandler(response)
    }
}

// MARK: - FMHCore.Endpoint generate URLRequest

private extension Core.Endpoint {

    func makeURLRequest(host: String) throws -> URLRequest {

        guard var urlComponents = URLComponents(string: host) else {
            throw NetworkingProviderError.invalidHost(String(describing: host))
        }

        urlComponents.path = path
        urlComponents.queryItems = self.query?.map {
            URLQueryItem(name: $0.key, value: $0.value?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
        }

        guard let url = urlComponents.url else {
            throw NetworkingProviderError.invalidUrl
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let body = body {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = body
        }

        self.headers?.forEach { request.addValue($0, forHTTPHeaderField: $1) }

        return request
    }
}

// MARK: - NetworkingProviderError

private enum NetworkingProviderError: Error, LocalizedError {
    case invalidHost(_ host: String)
    case invalidUrl
    case responseError(_ code: Int, _ description: String)
    
    var errorDescription: String? {
        switch self {
        case let .invalidHost(host):
            return "URLComponents not initialize: host = \(host)"
        case .invalidUrl:
            return "URLComponents.url not initialize."
        case let .responseError(code, description):
            return "ResponseError: [\(code)], \(description)"
        }
    }
}

// MARK: - Response handler

private extension NetworkingProvider {

    func responseHandler(_ response: (Data, URLResponse)) async throws -> (Data, URLResponse){

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

        throw NetworkingProviderError.responseError(urlResponse.statusCode, description)
    }
}
