//
//  CoordinatorFactoryProtocol.swift
//  fmh
//
//  Created: 09.05.2022
//

import Foundation

protocol CoordinatorFactoryProtocol {
    
    func makeAuthorizationCoordinator(router: Routable) -> Coordinatable & AuthorizationCoordinatorOutput
    func makeMainCoordinator(router: Routable)          -> Coordinatable & MainCoordinatorOutput
    
}
