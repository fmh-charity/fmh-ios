//
//  APIClient.swift
//  fmh
//
//  Created: 06.12.2022
//

import Foundation

protocol APIClientProtocol {
    
}


final class APIClient: APIService {
   
    static var shared: APIClient {
        let session = URLSession.shared
        session.configuration.urlCache = URLCache.shared
        return APIClient(urlSession: session)
    }
    
    private var accessToken: String? {
        Helper.Core.KeyChain.get(forKey: "accessToken")
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var request = request
        if let token = accessToken { request.setValue("\(token)", forHTTPHeaderField: "Authorization") }
        super.dataTask(with: request, completionHandler: completionHandler)
    }
    
}


//MARK: - APIClientProtocol
extension APIClient: APIClientProtocol {
    
    //TODO: ПРИ АВТОРИЗАЦИИ/РЕГИСТРАЦИИ - СТИРАТЬ КЕШЬ
    // self.urlSession.configuration.urlCache?.removeAllCachedResponses()
    
}

/*
private lazy var cache: URLCache = {
    let memoryCapacity = 1024 * 1024 * 4
    let diskCapacity = 1024 * 1024 * 20
    let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "ApiClient_Cached")
    return cache
}()

private lazy var session: URLSession = {
    let configuration = URLSessionConfiguration.default
    configuration.requestCachePolicy = .reloadIgnoringCacheData // .reloadRevalidatingCacheData
    configuration.urlCache = cache
    let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
    return session
}()
*/
