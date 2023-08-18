//
//  AppDependencies.swift
//  fmh
//
//  Created: 06.08.2023
//

import Foundation
import Coordinating

final class AppDependencies {

    let router: RouterProtocol
    
    public init(router: RouterProtocol) {
        self.router = router
    }
}
