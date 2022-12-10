//
//  NetworkService.swift
//  fmh
//
//  Created: 10.12.2022
//

import Foundation


//MARK: - Class
class NetworkService {
    
    let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    /// [Raw]
    func fetchRaw(with request: URLRequest?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        guard var request = request else {
            let _error = NSError(domain: "NetworkService", code: 1000, userInfo: [
                NSLocalizedDescriptionKey : "URLRequest equal nil"
            ])
            return completionHandler(nil, nil, _error)
        }
        
        if let token = TokenManager.get() {
            request.setValue("\(token)", forHTTPHeaderField: "Authorization")
        }
        
        urlSession.dataTask(with: request) { data, response, error in
            
            // Need loger ...
            if let urlStr = response?.url, let codeStr = (response as? HTTPURLResponse)?.statusCode {
                print("[ NetworkService.URL: \(urlStr), code: \(codeStr) ]")
            }
            if let token = request.allHTTPHeaderFields?["Authorization"] {
                print("[ token: \(token) ]")
            }
            
            guard error == nil, let response = response as? HTTPURLResponse else {
                return completionHandler(nil, response, error)
            }
            
            if (200..<299).contains(response.statusCode), let data = data {
                return completionHandler(data, response, nil)
            }
            
            let _error = NSError(domain: "NetworkService", code: response.statusCode, userInfo: [
                NSLocalizedDescriptionKey : "Answer is not equal code to 200...299. Code=\(response.statusCode)"
            ])
            
            return completionHandler(nil, response, _error)
        }
        .resume()
    }
    
}
