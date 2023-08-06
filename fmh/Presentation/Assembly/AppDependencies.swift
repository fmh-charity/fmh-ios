//
//  AppDependencies.swift
//  fmh
//
//  Created: 06.08.2023
//

import Foundation
import Core

struct AppDependencies {

    let router: Routing
    
    public init(router: Routing) {
        self.router = router
    }
}
