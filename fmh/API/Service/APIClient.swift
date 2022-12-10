//
//  APIClient.swift
//  fmh
//
//  Created: 06.12.2022
//

import Foundation

protocol APIClientProtocol: APIServiceProtocol {
    var userProfile: APIClient.UserProfile? { get }

    func login(login: String, password: String, onComplition: ((Error?) -> Void)?)
    func logout()
    func updateUserProfile(onComplition: ((APIClient.UserProfile?, Error?) -> Void)?)
}


final class APIClient: APIService {
    
    static var shared = APIClient(urlSession: URLSession.shared)
    
    // ЕСЛИ ОСТАВЛЯЕМ [ shared ] - ТО ПРИВАТНЫЙ ОСТАВЛЯЕМ init() !!!
    private override init(urlSession: URLSession) {
        super.init(urlSession: urlSession)
    }
    
    var userProfile: UserProfile?

}


//MARK: - APIClientProtocol
extension APIClient: APIClientProtocol {
    
    func login(login: String, password: String, onComplition: ((Error?) -> Void)? = nil) {
        
        var request = try? URLRequest(.POST, path: "/api/fmh/authentication/login")
        request?.httpBody = try? ["login": login, "password": password].data()
        
        super.fetchRaw(with: request) { [weak self] data, _, error in
            if let tokens: DTOJWT = try? data?.decode() {
                TokenManager.update(access: tokens.accessToken, refresh: tokens.refreshToken)
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
        TokenManager.clear()
        self.urlSession.configuration.urlCache?.removeAllCachedResponses()
    }
    
    func updateUserProfile(onComplition: ((UserProfile?, Error?) -> Void)? = nil) {
        let request = try? URLRequest(.GET, path: "/api/fmh/authentication/userInfo")
        self.fetch(request: request) { [weak self] data, _, error in
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
