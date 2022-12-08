//
//  APIClient.swift
//  fmh
//
//  Created: 06.12.2022
//

import Foundation

protocol APIClientProtocol {
    var userProfile: APIClient.UserProfile? { get }
    var didCaseInterruption: (() -> Void)? { get set }
    
    func login(login: String, password: String, onComplition: ((Error?) -> Void)?)
    func logout()
    func updateUserProfile(onComplition: ((APIClient.UserProfile?, Error?) -> Void)?)
}


final class APIClient: APIService {
    
    static var shared = APIClient(urlSession: URLSession.shared)
    
    private var accessToken: String? {
        Helper.Core.KeyChain.get(forKey: DTOJWT.CodingKeys.accessToken.rawValue)
    }
    
    var userProfile: UserProfile?
    var didCaseInterruption: (() -> Void)?
    
    // Raw ...
    override func dataTask(with request: URLRequest?, retry: Bool = true, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard var request = request else {
            let _error = NSError(domain: "APIClient", code: 1000, userInfo: [
                NSLocalizedDescriptionKey : "URLRequest equal nil"
            ])
            return completionHandler(nil, nil, _error)
        }
        if let token = accessToken { request.setValue("\(token)", forHTTPHeaderField: "Authorization") }
//        super.dataTask(with: request, completionHandler: completionHandler)
        super.dataTask(with: request) { data, response, error in
            if (response as? HTTPURLResponse)?.statusCode == 401, retry {
                self.refreshedTokens() { [weak self] error in
                    if let error = error {
                        self?.didCaseInterruption?()
                        return completionHandler(data, response, error)
                    }
                    self?.dataTask(with: request, retry: false, completionHandler: completionHandler)
                }
            } else {
                return completionHandler(data, response, error)
            }
        }
    }

    private func refreshedTokens(onComplition: ((Error?) -> Void)? = nil) {
        var request = try? URLRequest(.POST, path: "/api/fmh/authentication/refresh")
        let refreshToken = Helper.Core.KeyChain.get(forKey: DTOJWT.CodingKeys.refreshToken.rawValue)
        request?.httpBody = try? ["refreshToken": refreshToken].data()
        self.dataTask(with: request) { data, _, error in
            if let tokens: DTOJWT = try? data?.decode() {
                Helper.Core.KeyChain.set(value: tokens.accessToken, forKey: DTOJWT.CodingKeys.accessToken.rawValue)
                Helper.Core.KeyChain.set(value: tokens.refreshToken, forKey: DTOJWT.CodingKeys.refreshToken.rawValue)
                onComplition?(nil)
                return
            }
            onComplition?(error)
            return
        }
        self.urlSession.configuration.urlCache?.removeAllCachedResponses()
    }
    
}


//MARK: - APIClientProtocol
extension APIClient: APIClientProtocol {
    
    func login(login: String, password: String, onComplition: ((Error?) -> Void)? = nil) {
        var request = try? URLRequest(.POST, path: "/api/fmh/authentication/login")
        request?.httpBody = try? ["login": login, "password": password].data()
        self.dataTask(with: request) { [weak self] data, _, error in
            if let tokens: DTOJWT = try? data?.decode() {
                // ДОБАВИТЬ ДАТУ ЗАЛОГИНИВАНИЯ in def or plist
                Helper.Core.KeyChain.set(value: tokens.accessToken, forKey: DTOJWT.CodingKeys.accessToken.rawValue)
                Helper.Core.KeyChain.set(value: tokens.refreshToken, forKey: DTOJWT.CodingKeys.refreshToken.rawValue)
                self?.updateUserProfile() { ui, error in
                    if let error = error {
                        onComplition?(error)
                        return
                    }
                    onComplition?(nil)
                    return
                }
                return
            }
            onComplition?(error)
            return
        }
        self.urlSession.configuration.urlCache?.removeAllCachedResponses()
    }
    
    func logout() {
        self.userProfile = nil
        Helper.Core.KeyChain.del(key: DTOJWT.CodingKeys.accessToken.rawValue)
        Helper.Core.KeyChain.del(key: DTOJWT.CodingKeys.refreshToken.rawValue)
        self.urlSession.configuration.urlCache?.removeAllCachedResponses()
    }
    
    func updateUserProfile(onComplition: ((UserProfile?, Error?) -> Void)? = nil) {
        let request = try? URLRequest(.GET, path: "/api/fmh/authentication/userInfo")
        self.dataTask(with: request) { [weak self] data, _, error in
            if let data = data {
                do {
                    let userInfo: DTOUserInfo = try data.decode()
                    let _userProfile = UserProfile(isAdmin: userInfo.admin,
                                                   id: userInfo.id,
                                                   lastName: userInfo.lastName,
                                                   firstName: userInfo.firstName,
                                                   middleName: userInfo.middleName)
                    self?.userProfile = _userProfile
                    onComplition?(_userProfile, nil)
                    return
                } catch {
                    onComplition?(nil, error)
                    return
                }
            }
            onComplition?(nil, error)
            return
        }
    }
    
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
