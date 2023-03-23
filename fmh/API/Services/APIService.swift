//
//  APIService_.swift
//  fmh
//
//  Created: 10.12.2022
//

import Foundation

enum APIServiceRequestType {
    case cache, response, cacheWithResponse
}

enum APIServiceDataType {
    case cached, response, responseSame
}

typealias FetchOnCompletion = (URLRequest?, URLResponse?, Error?) -> ()
typealias FetchOnReceiveData = (Data, APIServiceDataType) -> ()

// MARK: - Protocol

protocol APIServiceProtocol {
    var didRefreshedTokensInterruption: ((_ userInfo: [String : Any]?) -> Void)? { get set }
    
    func fetchData(with request: URLRequest?, retry: Bool, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
    func fetchData(request: URLRequest?, requestType: APIServiceRequestType, retry: Bool, onReceiveData: @escaping FetchOnReceiveData, onCompletion: FetchOnCompletion?)
    func fetch<T: Decodable>(with request: URLRequest?, retry: Bool, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void)
}

extension APIServiceProtocol {
    
    func fetch<T: Decodable>(with request: URLRequest?, retry: Bool = true, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) {
        fetch(with: request, retry: retry, completionHandler: completionHandler)
    }
    
    func fetchData(request: URLRequest?, requestType: APIServiceRequestType, retry: Bool = true, onReceiveData: @escaping FetchOnReceiveData, onCompletion: FetchOnCompletion? = nil) {
        fetchData(request: request, requestType: requestType, retry: retry, onReceiveData: onReceiveData, onCompletion: onCompletion)
    }
}

// MARK: - Class

class APIService: NetworkService {
    
    var didRefreshedTokensInterruption: ((_ userInfo: [String : Any]?) -> Void)?
    
    private func fetch(with request: URLRequest?, retry: Bool, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var request = request
        
        if let token = TokenManager.get() {
            request?.setValue("\(token)", forHTTPHeaderField: "Authorization")
        }
        
        super.dataTask(with: request) { data, response, error in
            if (response as? HTTPURLResponse)?.statusCode == 401, retry {
                self.refreshedTokens() { [weak self] error in
                    if let error = error {
                        completionHandler(data, response, error)
                        DispatchQueue.main.async {
                            self?.didRefreshedTokensInterruption?(["error":error])
                        }
                        return
                    }
                    self?.fetch(with: request, retry: false, completionHandler: completionHandler)
                    return
                }
            } else {
                completionHandler(data, response, error)
                return
            }
        }
    }
    
    private func refreshedTokens(onCompletion: ((Error?) -> Void)? = nil) {
        
        var request = try? URLRequest(.POST, path: "/api/fmh/authentication/refresh")
        let refreshToken = TokenManager.get(.refreshToken)
        request?.httpBody = try? ["refreshToken": refreshToken].data()
        
        super.dataTask(with: request) { data, _, error in
            if let tokens: DTOJWT = try? data?.decode() {
                TokenManager.update(access: tokens.accessToken, refresh: tokens.refreshToken)
                onCompletion?(nil)
                return
            }
            onCompletion?(error)
            return
        }
        self.urlSession.configuration.urlCache?.removeAllCachedResponses()
    }
}


// MARK: - APIServiceProtocol

extension APIService: APIServiceProtocol {
    
    func fetchData(with request: URLRequest?, retry: Bool, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.fetch(with: request, retry: retry, completionHandler: completionHandler)
    }
    
    func fetchData(request: URLRequest?, requestType: APIServiceRequestType, retry: Bool, onReceiveData: @escaping FetchOnReceiveData, onCompletion: FetchOnCompletion?) {
        
        let cache = urlSession.configuration.urlCache
        var cachedData: Data?
        
        let isCached = (requestType == .cache) || (requestType == .cacheWithResponse)
        
        if isCached, let request = request, let _cachedData = cache?.cachedResponse(for: request)?.data {
            cachedData = _cachedData
            onReceiveData(_cachedData, .cached)
            
            if requestType == .cache {
                onCompletion?(request, nil, nil)
                return
            }
        }
        
        self.fetch(with: request, retry: retry) { data, response, error in
            
            if let data = data {
                
                if isCached, data == cachedData {
                    onReceiveData(data, .responseSame)
                } else {
                    onReceiveData(data, .response)
                }
                
                if isCached, let request = request, let response = response  {
                    let _cachedData = CachedURLResponse(response: response, data: data)
                    cache?.storeCachedResponse(_cachedData, for: request)
                }
            }
            
            onCompletion?(request, response, error)
        }
    }
    
    func fetch<T: Decodable>(with request: URLRequest?, retry: Bool, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) {
        self.fetch(with: request, retry: retry) { data, response, error in
            guard error == nil else { completionHandler(nil, response, error); return }
            if let data {
                do{
                    let decodeData = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(decodeData, response, error)
                    return
                } catch {
                    completionHandler(nil, response, error)
                    return
                }
            }
            completionHandler(nil, response, error)
            return
        }
    }
}
