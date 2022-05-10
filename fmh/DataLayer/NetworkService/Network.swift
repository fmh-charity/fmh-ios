//
//  Network.swift
//  fmh
//
//  Created: 09.05.2022
//

import Foundation
import Combine

protocol NetworkProtocol: AnyObject {
    
    func fetchDataPublisher <T> (resource: APIResource<T>) -> AnyPublisher<T, APIError> where T: Decodable
    
}


class Network: Service {
    
    init() { }
    
    // MARK: - Private variable
    private var anyCancellable = Set<AnyCancellable>()
    
    private(set) var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        config.timeoutIntervalForRequest = 30.0
        config.urlCache = .none
        
        return URLSession(configuration: config, delegate: .none, delegateQueue: .none)
    }()
    
    private var baseURLString: String? {
        PListParser.getValueDictionary(forResource: "NetworkService", forKey: "testBaseURLString") as? String
    }
    
    private var globalPath: String? {
        PListParser.getValueDictionary(forResource: "NetworkService", forKey: "globalPath") as? String
    }
    
    private var globalHeaders: HTTPHeaders? {
        [ "application/json; charset=utf-8" : "Content-Type" ] // добавить ios ?
    }
    
}

// MARK: - Network_Protocol
extension Network: NetworkProtocol {
    
    func fetchDataPublisher <T> (resource: APIResource<T>) -> AnyPublisher<T, APIError> where T: Decodable {
        guard let url = makeURL(path: resource.path, parametrs: resource.parametrs) else {
            return Fail(error: APIError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        let encodeBody = try? resource.body?.encode()
        var request = makeRequest(url: url, method: resource.method, headers: resource.headers, body: encodeBody)
        if let accessToken = AppSession.tokens?.accessToken, !(resource.body.self is Credentials)  {
            request.setValue("\(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        return fetchPublisher(request: request)
            .tryCatch { [unowned self] apiError -> AnyPublisher<Data, APIError> in
                if apiError.code == 401 && !(resource.body.self is Credentials) && AppSession.isAuthorized {
                    self.refreshToken().sink { _ in }
                        receiveValue: { tokenData in
                            AppSession.tokens = tokenData
                        }
                        .store(in: &anyCancellable)
                    
                    if let accessToken =  AppSession.tokens?.accessToken {
                        request.setValue("\(accessToken)", forHTTPHeaderField: "Authorization")
                    }
                    return fetchPublisher(request: request)
                }
                throw apiError
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                    error as! APIError
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}

extension Network {

    func refreshToken () -> AnyPublisher<TokenData, APIError> {
        
        // TODO:  Переделать, нужно просто вызывать APIResource
        let refreshToken = AppSession.tokens?.refreshToken ?? ""
        let resource: APIResource<TokenData> = APIResource(path: "authentication/refresh",
                                                           method: .post,
                                                           body: RefreshToken(refreshToken: refreshToken))
        let url = makeURL(path: resource.path)!
        let encodeBody = try? resource.body?.encode()
        let request = makeRequest(url: url, method: resource.method, body: encodeBody)

        return fetchPublisher(request: request)
            .map { $0 }
            .decode(type: TokenData.self, decoder: JSONDecoder())
            .mapError { error in error as! APIError }
            .eraseToAnyPublisher()
    }

}

// MARK: - Factory methods (Private)
extension Network {
    
    // TODO: !!! Рассмотреть возможность переноса в extension URL
    private func makeURL(path: String, parametrs: URLParameters? = nil) -> URL? {
        guard let url = URL(string: self.baseURLString ?? "") else { return nil }
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }
        components.path = (globalPath ?? "/") + path
        parametrs?.forEach{ components.queryItems?.append(URLQueryItem(name: $0, value: $1)) }
        return components.url
    }
    
    // TODO: !!! Рассмотреть возможность переноса в extension URLRequest
    private func makeRequest(url: URL, method: HTTPMethod, headers: HTTPHeaders? = nil, body: Data? = nil) -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5 )
        request.httpMethod = method.rawValue
        request.httpBody = body
        globalHeaders?.forEach{ request.addValue($0, forHTTPHeaderField: $1) }
        headers?.forEach{ request.addValue($0, forHTTPHeaderField: $1) }
        return request
    }
    
}
