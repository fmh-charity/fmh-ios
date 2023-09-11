//
//  AppDependencies.swift
//  fmh
//
//  Created: 06.08.2023
//

import Foundation
import Coordinating
import Networking
import Authorization

final class AppDependencies {

    let router: RouterProtocol
    let network: NetworkProtocol
    let tokenProvider: TokenProviderProtocol
    
    public init(
        router: RouterProtocol,
        network: NetworkProtocol,
        tokenProvider: TokenProviderProtocol
    ) {
        self.router = router
        self.network = network
        self.tokenProvider = tokenProvider
    }
}
