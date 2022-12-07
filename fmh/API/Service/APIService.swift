//
//  APIService.swift
//  fmh
//
//  Created: 06.12.2022
//

import Foundation

enum APIServiceDataType {
    case cached, response, responseSame
}

typealias FetchDataOnCompletion = (URLRequest, URLResponse?, Error?) -> ()
typealias FetchDataOnReciveData = (Data, APIServiceDataType) -> ()


protocol APIServiceProtocol {
    
    func fetchData(request: URLRequest, onCompletion: @escaping (Data?, URLResponse?, Error?) -> Void)
    func fetchData(request: URLRequest, onCompletion: @escaping (Result<Data, Error>) -> Void)
    
    ///  Запрос с использованием URLCache.
    ///   - Если есть данные в URLCache то возвращаются данные с параметром: cached
    ///   - далее делается запрос и сопоставляются данные URLCache и Response,
    ///     - если не езменены то возвращаются с параметром: responseSame
    ///     - если езменены то возвращаются с параметром: response
    func fetchData(request: URLRequest, isCached: Bool, onReciveData: @escaping FetchDataOnReciveData, onCompletion: FetchDataOnCompletion?)
}


class APIService {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    //MARK: Private methods [ Raw ] -
    
    /// URLSession.dataTask [Raw]
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        urlSession.dataTask(with: request) { data, response, error in
            guard error == nil, let response = response as? HTTPURLResponse else {
                return completionHandler(nil, response, error)
            }
            if (200..<300).contains(response.statusCode), let data = data {
                return completionHandler(data, response, nil)
            }
            let _error = NSError(domain: "URLResponse", code: response.statusCode)
            return completionHandler(nil, response, _error)
        }
        .resume()
    }
    
    // ...
    
}


//MARK: - APIServiceProtocol
extension APIService: APIServiceProtocol {
    
    /// Main method [Priority]
    func fetchData(request: URLRequest, isCached: Bool = false, onReciveData: @escaping FetchDataOnReciveData, onCompletion: FetchDataOnCompletion?) {
        
        let cache = urlSession.configuration.urlCache
        var cachedData: Data?
        if isCached, let _cachedData = cache?.cachedResponse(for: request)?.data {
            cachedData = _cachedData
            onReciveData(_cachedData, .cached)
        }
        
        dataTask(with: request) { data, response, error in
            
            if let data = data, let response = response {
                
                if isCached, data == cachedData {
                    onReciveData(data, .responseSame)
                } else {
                    onReciveData(data, .response)
                }
                
                if isCached {
                    let _cachedData = CachedURLResponse(response: response, data: data)
                    cache?.storeCachedResponse(_cachedData, for: request)
                }
                
            }
            
            onCompletion?(request, response, error)
        }
        
    }
    
    func fetchData(request: URLRequest, onCompletion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        dataTask(with: request, completionHandler: onCompletion)
    }
    
    func fetchData(request: URLRequest, onCompletion: @escaping (Result<Data, Error>) -> Void) {
        dataTask(with: request) { data, response, error in
            if let error = error {
                return onCompletion(.failure(error))
            }
            if let data = data {
                return onCompletion(.success(data))
            }
        }
    }
     
}
