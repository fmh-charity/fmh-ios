//
//  APIClient.swift
//  fmh
//
//  Created: 06.12.2022
//

import Foundation

protocol APIClientProtocol: APIServiceProtocol {
    var userProfile: APIClient.UserProfile? { get }
    
    func isAuthorized() -> Bool
    func login(login: String, password: String, onCompletion: ((Error?) -> Void)?)
    func logout()
    func updateUserProfile(onCompletion: ((APIClient.UserProfile?, Error?) -> Void)?)
}

// MARK: - Class

final class APIClient: APIService {
    
    static var shared = APIClient(urlSession: URLSession.shared)
    
    // TODO: ЕСЛИ ОСТАВЛЯЕМ [ shared ] - ТО ПРИВАТНЫЙ ОСТАВЛЯЕМ init() !!!
    
    override init(urlSession: URLSession) {
        super.init(urlSession: urlSession)
    }
    
    private(set) var userProfile: UserProfile?
}


// MARK: - APIClientProtocol

extension APIClient: APIClientProtocol {
    
    func isAuthorized() -> Bool {
        !TokenManager.isEmpty()
    }
    
    func login(login: String, password: String, onCompletion: ((Error?) -> Void)? = nil) {
        
        var request = try? URLRequest(.POST, path: "/api/fmh/authentication/login")
        request?.httpBody = try? ["login": login, "password": password].data()
        
        TokenManager.clear()
        
        super.dataTask(with: request) { [weak self] data, _, error in
            if let tokens: DTOJWT = try? data?.decode() {
                TokenManager.update(access: tokens.accessToken, refresh: tokens.refreshToken)
                self?.updateUserProfile() { ui, error in
                    if let error = error {
                        onCompletion?(error)
                        return
                    }
                    onCompletion?(nil)
                    return
                }
                return
            }
            onCompletion?(error)
            return
        }
        self.urlSession.configuration.urlCache?.removeAllCachedResponses()
    }
    
    func logout() {
        self.userProfile = nil
        TokenManager.clear()
        self.urlSession.configuration.urlCache?.removeAllCachedResponses()
    }
    
    func updateUserProfile(onCompletion: ((UserProfile?, Error?) -> Void)? = nil) {
        
        let request = try? URLRequest(.GET, path: "/api/fmh/authentication/userInfo")
        
        self.fetch(with: request) { [weak self] decodeData, response, error in
            
            if let userInfo: DTOUserInfo = decodeData {
                let _userProfile = UserProfile(isAdmin: userInfo.admin,
                                               id: userInfo.id,
                                               lastName: userInfo.lastName,
                                               firstName: userInfo.firstName,
                                               middleName: userInfo.middleName)
                self?.userProfile = _userProfile
                onCompletion?(_userProfile, nil)
                return
            }
            
            onCompletion?(nil, error)
        }
    }
}
