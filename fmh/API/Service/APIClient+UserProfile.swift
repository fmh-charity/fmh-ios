//
//  APIClient+UserProfile.swift
//  fmh
//
//  Created: 07.12.2022
//

import Foundation

extension APIClient {
    
    class UserProfile {
        let isAdmin: Bool
        let id: Int
        let lastName: String
        let firstName: String
        let middleName: String
        
        init(isAdmin: Bool, id: Int, lastName: String, firstName: String, middleName: String) {
            self.isAdmin = isAdmin
            self.id = id
            self.lastName = lastName
            self.firstName = firstName
            self.middleName = middleName
        }
        
    }
    
}

extension APIClient {
    
    var dataLogin: Date {
        return Date() // СЧИТЫВАТЬ С def or plist
    }
    
}
