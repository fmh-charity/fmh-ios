//
//  APIService_.swift
//  fmh
//
//  Created: 10.12.2022
//

import Foundation

enum APIServiceDataType {
    case cached, response, responseSame
}

typealias FetchDataOnCompletion = (URLRequest?, URLResponse?, Error?) -> ()
typealias FetchDataOnReciveData = (Data, APIServiceDataType) -> ()


//MARK: Protocol -
protocol APIServiceProtocol {

    /// Interrupt handler
    var didCaseInterruption: ((_ userInfo: [String : Any]?) -> Void)? { get set }
    
    /// Main method [Priority]
    func fetch(request: URLRequest?, isCached: Bool, onReciveData: @escaping FetchDataOnReciveData, onCompletion: FetchDataOnCompletion?)
    
    func fetch(request: URLRequest?, onCompletion: @escaping (Data?, URLResponse?, Error?) -> Void)
    func fetch(request: URLRequest?, onCompletion: @escaping (Result<Data, Error>) -> Void)
    
    func fetch<T>(request: URLRequest?, onCompletion: @escaping (T?, URLResponse?, Error?) -> Void)

}


//MARK: Class -
class APIService: NetworkService {
    
//    static var shared = APIService(urlSession: URLSession.shared)

    var didCaseInterruption: ((_ userInfo: [String : Any]?) -> Void)?
    
    /// [Raw]. Default  retry if response = 401
    private func fetch(with request: URLRequest?, retry: Bool, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        super.fetchRaw(with: request) { data, response, error in
            if (response as? HTTPURLResponse)?.statusCode == 401, retry {
                self.refreshedTokens() { [weak self] error in
                    if let error = error {
                        completionHandler(data, response, error)
                        self?.didCaseInterruption?(["error":error])
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
    
    /// Refreshed token in store
    private func refreshedTokens(onComplition: ((Error?) -> Void)? = nil) {
        var request = try? URLRequest(.POST, path: "/api/fmh/authentication/refresh")
        let refreshToken = TokenManager.get(.refreshToken)
        request?.httpBody = try? ["refreshToken": refreshToken].data()
        super.fetchRaw(with: request) { data, _, error in
            if let tokens: DTOJWT = try? data?.decode() {
                TokenManager.update(access: tokens.accessToken, refresh: tokens.refreshToken)
                onComplition?(nil)
                return
            }
            onComplition?(error)
            return
        }
        self.urlSession.configuration.urlCache?.removeAllCachedResponses()
    }
    
}


//MARK: - APIServiceProtocol
extension APIService: APIServiceProtocol {
    
    /// Main method [Priority]
    func fetch(request: URLRequest?, isCached: Bool = false, onReciveData: @escaping FetchDataOnReciveData, onCompletion: FetchDataOnCompletion?) {
        
        let cache = urlSession.configuration.urlCache
        var cachedData: Data?
        if isCached, let request = request, let _cachedData = cache?.cachedResponse(for: request)?.data {
            cachedData = _cachedData
            onReciveData(_cachedData, .cached)
        }
        
        self.fetch(with: request, retry: true) { data, response, error in
    
            if let data = data, let response = response {
                
                if isCached, data == cachedData {
                    onReciveData(data, .responseSame)
                } else {
                    onReciveData(data, .response)
                }
                
                if isCached, let request = request {
                    let _cachedData = CachedURLResponse(response: response, data: data)
                    cache?.storeCachedResponse(_cachedData, for: request)
                }
                
            }
            
            onCompletion?(request, response, error)
        }
        
    }
    
    func fetch(request: URLRequest?, onCompletion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.fetch(with: request, retry: true, completionHandler: onCompletion)
    }
    
    func fetch(request: URLRequest?, onCompletion: @escaping (Result<Data, Error>) -> Void) {
        self.fetch(with: request, retry: true) { data, response, error in
            
            if let data = data {
                return onCompletion(.success(data))
            }
            
            if let error = error {
                return onCompletion(.failure(error))
            }
            
        }
    }
    
    func fetch<T: Decodable>(request: URLRequest?, onCompletion: @escaping (T?, URLResponse?, Error?) -> Void) {
        self.fetch(with: request, retry: true) { data, response, error in
            guard error == nil else { return onCompletion(nil, response, error) }
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
            return onCompletion(nil, response, error)
        }
    }
    
}
