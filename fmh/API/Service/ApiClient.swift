//
//  ApiClient.swift
//  fmh
//
//  Created: 26.11.2022
//

import Foundation

protocol ApiClientProtocol {

}


class ApiClient: URLSessionProtocol {
    
    static let shared = ApiClient()
    
    private lazy var cache: URLCache = {
        let memoryCapacity = 1024 * 1024 * 4
        let diskCapacity = 1024 * 1024 * 20
        let cache = URLCache(memoryCapacity: 0, diskCapacity: diskCapacity, diskPath: "ApiClient_Cached")
        return cache
    }()
    
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = cache
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        return session
    }()

    init() {
        
    }
    
}


//MARK: - ApiClientProtocol
extension ApiClient: ApiClientProtocol {
    
    typealias FetchDataOnCompletion = (URLRequest?, URLResponse?, Error?) -> ()
    typealias FetchDataOnReciveData = (Data, ApiClientDataType) -> ()
    
    func getData(request: URLRequest, isWithCached: Bool = false, onReciveData: @escaping FetchDataOnReciveData, onCompletion: FetchDataOnCompletion?) {
        
        var cachedData: Data?
        if isWithCached, let _cachedData = self.cache.cachedResponse(for: request) {
            cachedData = _cachedData.data
            onReciveData(_cachedData.data, .cached)
        }
        
        fetchData(request: request) { [weak self] data, response, error in
            
            if let data = data, let response = response {
                
                if isWithCached, data == cachedData {
                    onReciveData(data, .responseSame)
                } else {
                    onReciveData(data, .response)
                }
                
                if isWithCached {
                    let _cachedData = CachedURLResponse(response: response, data: data)
                    self?.cache.storeCachedResponse(_cachedData, for: request)
                }
            }
            
            onCompletion?(request, response, error)
        }
    }
    
}


//MARK: - Helpers

enum ApiClientDataType {
    case cached, response, responseSame
}

enum ApiClientOnCompletion {
    case Success
    case Failure(Error)
}
