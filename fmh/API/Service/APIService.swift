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

typealias FetchDataOnCompletion = (URLRequest?, URLResponse?, Error?) -> ()
typealias FetchOnReceiveData = (Data, APIServiceDataType) -> ()
typealias FetchDataOnReceiveData<T: Decodable> = (T, APIServiceDataType) -> ()

//MARK: - Protocol

protocol APIServiceProtocol {
    var didCaseInterruption: ((_ userInfo: [String : Any]?) -> Void)? { get set }
    
    func fetch(request: URLRequest?, requestType: APIServiceRequestType, onReceiveData: @escaping FetchOnReceiveData, onCompletion: FetchDataOnCompletion?)
    func fetchData<T: Decodable>(request: URLRequest?, onCompletion: @escaping (T?, URLResponse?, Error?) -> Void)
}

//MARK: - Class

class APIService: NetworkService {
    
    var didCaseInterruption: ((_ userInfo: [String : Any]?) -> Void)?
    
    private func fetch(with request: URLRequest?, retry: Bool, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        super.dataTask(with: request) { data, response, error in
            if (response as? HTTPURLResponse)?.statusCode == 401, retry {
                self.refreshedTokens() { [weak self] error in
                    if let error = error {
                        completionHandler(data, response, error)
                        DispatchQueue.main.async {
                            self?.didCaseInterruption?(["error":error])
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


//MARK: - APIServiceProtocol

extension APIService: APIServiceProtocol {
    
    func fetch(request: URLRequest?, requestType: APIServiceRequestType, onReceiveData: @escaping FetchOnReceiveData, onCompletion: FetchDataOnCompletion?) {
        
        let cache = urlSession.configuration.urlCache
        var cachedData: Data?
        
        let isCached = (requestType == .cache) || (requestType == .cacheWithResponse)
        
        if isCached, let request = request, let _cachedData = cache?.cachedResponse(for: request)?.data {
            cachedData = _cachedData
            onReceiveData(_cachedData, .cached)
            
            if requestType == .cache { return }
        }
        
        self.fetch(with: request, retry: true) { data, response, error in
    
            if let data = data, let response = response {
                
                if isCached, data == cachedData {
                    onReceiveData(data, .responseSame)
                } else {
                    onReceiveData(data, .response)
                }
                
                if isCached, let request = request {
                    let _cachedData = CachedURLResponse(response: response, data: data)
                    cache?.storeCachedResponse(_cachedData, for: request)
                }
            }
            
            onCompletion?(request, response, error)
        }
    }
    
    func fetchData<T: Decodable>(request: URLRequest?, onCompletion: @escaping (T?, URLResponse?, Error?) -> Void) {
        self.fetch(with: request, retry: true) { data, response, error in
            guard error == nil else { onCompletion(nil, response, error); return }
            if let data = data {
                do{
                    let decodeData = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async { onCompletion(decodeData, response, error) }
                    return
                } catch {
                    DispatchQueue.main.async { onCompletion(nil, response, error) }
                    return
                }
            }
            onCompletion(nil, response, error)
            return
        }
    }
}
