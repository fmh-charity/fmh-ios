//
//  AppUser.swift
//  fmh
//
//  Created: 06.05.2022
//

import Foundation

class AppUser {
    
    var accessToken: String?
    var refreshToken: String?
    
    var isLogin: Bool?
    
    init() {
        if let accessToken = KeyChain.standart.get(forKey: "accessToken"),
           let refreshToken = KeyChain.standart.get(forKey: "refreshToken"){
            self.accessToken = accessToken
            self.refreshToken = refreshToken
            self.isLogin = true
        }
    }
    
    func login(tokenData: TokenData) {
        KeyChain.standart.set(value: tokenData.accessToken, forKey: "accessToken")
        KeyChain.standart.set(value: tokenData.refreshToken, forKey: "refreshToken")
        self.accessToken = tokenData.accessToken
        self.refreshToken = tokenData.refreshToken
        self.isLogin = true
    }
    
    func refresh(tokenData: TokenData) {
        login(tokenData: tokenData)
    }
    
    func logout() {
        KeyChain.standart.del(key: "accessToken")
        KeyChain.standart.del(key: "refreshToken")
        self.accessToken = nil
        self.refreshToken = nil
        self.isLogin = false
    }
    
}
