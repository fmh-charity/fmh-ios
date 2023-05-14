//
//  Example.swift
//  fmh
//
//  Created: 05.04.2023
//
/*
import Foundation
import Combine

enum NetworkError: Error {
    case invalidResponse
    case decodingError
    case serverError(String)
    case unauthorized
    case tokenError
}

struct NetworkResponse<T> {
    let value: T
    let response: URLResponse
}

protocol NetworkService {
    func execute<T: Decodable>(request: URLRequest, decodeType: T.Type, accessToken: String?, refreshToken: String) -> AnyPublisher<NetworkResponse<T>, NetworkError>
}

class URLSessionNetworkService: NetworkService {
    private let session: URLSession
    private var accessToken: String?
    private let tokenProvider: TokenProvider
    
    init(session: URLSession = URLSession.shared, tokenProvider: TokenProvider) {
        self.session = session
        self.tokenProvider = tokenProvider
    }
    
    func execute<T: Decodable>(request: URLRequest, decodeType: T.Type, accessToken: String? = nil, refreshToken: String) -> AnyPublisher<NetworkResponse<T>, NetworkError> {
        var request = request
        if let accessToken = accessToken {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        } else if let accessToken = self.accessToken {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        return session.dataTaskPublisher(for: request)
            .tryMap { result -> NetworkResponse<T> in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                guard 200..<300 ~= httpResponse.statusCode else {
                    let serverErrorMessage = String(data: result.data, encoding: .utf8) ?? ""
                    if httpResponse.statusCode == 401 {
                        throw NetworkError.unauthorized
                    } else {
                        throw NetworkError.serverError(serverErrorMessage)
                    }
                }
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let value = try decoder.decode(T.self, from: result.data)
                return NetworkResponse(value: value, response: result.response)
            }
            .mapError { error -> NetworkError in
                if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return NetworkError.decodingError
                }
            }
            .retryWhen { errors -> AnyPublisher<Void, Error> in
                return errors.flatMap { error -> AnyPublisher<Void, Error> in
                    guard error == NetworkError.unauthorized else {
                        return Fail(error: error).eraseToAnyPublisher()
                    }
                    
                    // Обновление токена
                    let refreshTokenRequest = self.tokenProvider.refreshTokenRequest(refreshToken: refreshToken)
                    return self.session.dataTaskPublisher(for: refreshTokenRequest)
                        .tryMap { result -> Void in
                            guard let httpResponse = result.response as? HTTPURLResponse else {
                                throw NetworkError.invalidResponse
                            }
                            guard 200..<300 ~= httpResponse.statusCode else {
                                let serverErrorMessage = String(data: result.data, encoding: .utf8) ?? ""
                                throw NetworkError.serverError(serverErrorMessage)
                            }
                            let decoder = JSONDecoder()
                            decoder.dateDecodingStrategy = .iso8601
                            let token = try decoder.decode(Token.self, from: result.data)
                            self.accessToken = token.accessToken
                            request.setValue("Bearer \(self.accessToken!)", forHTTPHeaderField: "Authorization")
                            return ()
                        }
                        .tryCatch { error -> AnyPublisher<Void, Error> in
                            return Fail(error: NetworkError.tokenError).eraseToAnyPublisher()
                        }
                        .eraseToAnyPublisher()
                }
            }
    }
}
*/

/*
 import Foundation
 import Combine

 enum NetworkError: Error {
     case invalidResponse
     case decodingError
     case serverError(String)
     case unauthorized
     case tokenError
 }

 struct NetworkResponse<T> {
     let value: T
     let response: URLResponse
 }

 struct NetworkResponseWithToken<T> {
     let value: T
     let accessToken: String
     let response: URLResponse
 }

 protocol NetworkService {
     func execute<T: Decodable>(request: URLRequest, decodeType: T.Type, accessToken: String?, refreshToken: String) -> AnyPublisher<NetworkResponse<T>, NetworkError>
 }

 class URLSessionNetworkService: NetworkService {
     private let session: URLSession
     private var accessToken: String?
     private let tokenProvider: TokenProvider
     
     init(session: URLSession = URLSession.shared, tokenProvider: TokenProvider) {
         self.session = session
         self.tokenProvider = tokenProvider
     }
     
     func execute<T: Decodable>(request: URLRequest, decodeType: T.Type, accessToken: String? = nil, refreshToken: String) -> AnyPublisher<NetworkResponse<T>, NetworkError> {
         var request = request
         if let accessToken = accessToken {
             request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
         } else if let accessToken = self.accessToken {
             request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
         }
         
         return session.dataTaskPublisher(for: request)
             .tryMap { result -> NetworkResponseWithToken<T> in
                 guard let httpResponse = result.response as? HTTPURLResponse else {
                     throw NetworkError.invalidResponse
                 }
                 guard 200..<300 ~= httpResponse.statusCode else {
                     let serverErrorMessage = String(data: result.data, encoding: .utf8) ?? ""
                     if httpResponse.statusCode == 401 {
                         throw NetworkError.unauthorized
                     } else {
                         throw NetworkError.serverError(serverErrorMessage)
                     }
                 }
                 let decoder = JSONDecoder()
                 decoder.dateDecodingStrategy = .iso8601
                 let value = try decoder.decode(T.self, from: result.data)
                 let accessToken = httpResponse.allHeaderFields["Authorization"] as? String ?? ""
                 return NetworkResponseWithToken(value: value, accessToken: accessToken, response: result.response)
             }
             .map { responseWithToken -> NetworkResponse<T> in
                 self.accessToken = responseWithToken.accessToken
                 return NetworkResponse(value: responseWithToken.value, response: responseWithToken.response)
             }
             .mapError { error -> NetworkError in
                 if let networkError = error as? NetworkError {
                     return networkError
                 } else {
                     return NetworkError.decodingError
                 }
             }
             .retryWhen { errors -> AnyPublisher<Void, Error> in
                 return errors.flatMap { error -> AnyPublisher<Void, Error> in
                     guard error == NetworkError.unauthorized else {
                         return Fail(error: error).eraseToAnyPublisher()
                     }
                     
                     // Обновление токена
                     let refreshTokenRequest = self.tokenProvider.refreshTokenRequest(refreshToken: refreshToken)
                     return self.session.dataTaskPublisher(for: refreshTokenRequest)
                         .tryMap { result -> Void in
                             guard let httpResponse = result.response as? HTTPURLResponse else {
                                 throw NetworkError.invalidResponse
                             }
                             guard 200..<300 ~= httpResponse.statusCode else {
                                 let serverErrorMessage = String(data: result.data, encoding: .utf8) ?? ""
                                 throw NetworkError.serverError(serverErrorMessage)
                             }
                             let decoder = JSONDecoder()
                             decoder.dateDecodingStrategy = .iso

 */
