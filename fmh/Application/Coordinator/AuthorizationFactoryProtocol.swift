//
//  AuthorizationFactoryProtocol.swift
//  fmh
//
//  Created: 09.05.2022
//

import Foundation

protocol AuthorizationFactoryProtocol {
    func makeAuthorizationView() -> AuthorizationViewProtocol
}
