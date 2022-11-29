//
//  ApiURLProtocol.swift
//  fmh
//
//  Created: 27.11.2022
//

import Foundation

final class ApiURLProtocol: URLProtocol {
    
    var connection: NSURLConnection!
    
    override class func canInit(with request: URLRequest) -> Bool {
        false
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        print(request)
        return request
    }
    
    static var loadingHandler: ((URLRequest) -> (HTTPURLResponse, Data?, Error?))?
    
    override func startLoading() {
        
        self.connection = NSURLConnection(request: self.request, delegate: self, startImmediately: true)
        
        //            guard let handler = ApiURLProtocol.loadingHandler else {
        //                print("Loading handler is not set.")
        //                return
        //            }
        //            let (response, data, error) = handler(request)
        //            if let data = data {
        //                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        //                client?.urlProtocol(self, didLoad: data)
        //                client?.urlProtocolDidFinishLoading(self)
        //            }
        //            else {
        //                client?.urlProtocol(self, didFailWithError: error!)
        //            }
        
    }
    
    override func stopLoading() {
        if self.connection != nil {
            self.connection.cancel()
        }
        self.connection = nil
    }
}

extension ApiURLProtocol: NSURLConnectionDelegate {
    func connection(_ connection: NSURLConnection, didFailWithError error: Error) {
        client?.urlProtocol(self, didFailWithError: error)
    }
    func connectionShouldUseCredentialStorage(_ connection: NSURLConnection) -> Bool {
        true
    }
    func connection(_ connection: NSURLConnection, didReceive challenge: URLAuthenticationChallenge) {
        client?.urlProtocol(self, didReceive: challenge)
    }
    func connection(_ connection: NSURLConnection, didCancel challenge: URLAuthenticationChallenge) {
        client?.urlProtocol(self, didCancel: challenge)
    }
}
