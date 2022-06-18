//
//  AppSession.swift
//  fmh
//
//  Created: 10.05.2022
//

import Foundation

// TODO: Необходим Class и передавать его (т.к. на данный момент не сохраняется userInfo)
// TODO: Передавать в Network ?

struct AppSession {
    
    static var isAuthorized: Bool {
        return self.tokens != nil
    }
    
    static var tokens: DTOTokenData? {
        get {
            if let accessToken = KeyChain.standart.get(forKey: "accessToken"),
               let refreshToken = KeyChain.standart.get(forKey: "refreshToken") {
                return DTOTokenData(accessToken: accessToken, refreshToken: refreshToken)
            }
            return nil
        }
        set {
            guard let tokenData = newValue else { return }
            KeyChain.standart.set(value: tokenData.accessToken, forKey: "accessToken")
            KeyChain.standart.set(value: tokenData.refreshToken, forKey: "refreshToken")
        }
    }
    
    static var userInfo: DTOUserInfo? // <- Записывать во время загрузочной страницы (далее пересмотрим)
    
    static func logOut () {
        KeyChain.standart.del(key: "accessToken")
        KeyChain.standart.del(key: "refreshToken")
    }
    
    
}
