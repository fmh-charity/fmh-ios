//
//  TokenProviderProtocol.swift
//  fmh
//
//  Created: 16.05.2023
//

import Foundation

protocol TokenProviderProtocol {
    func getAccessToken() async throws -> String
    func getRefreshToken() async throws -> String
    func setTokens(accessToken: String?, refreshToken: String?) async
}
