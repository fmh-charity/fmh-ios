//
//  Coordinator.swift
//  fmh
//
//  Created: 23.11.2022
//

import Foundation

protocol CoordinatorProtocol : AnyObject {
    var childCoordinators: [CoordinatorProtocol] { get set }
    var router: RouterProtocol { get }
    var onCompletion: (() -> Void)? { get set }
    func start()
}

// MARK: - Coordinator

class Coordinator: CoordinatorProtocol {
    
    var childCoordinators = [CoordinatorProtocol]()
    var router: RouterProtocol
    var onCompletion: (() -> Void)?
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    func start() {
        fatalError("CoordinatorBase: Need override in heir coordinator.")
    }
}

// MARK: - Logic

extension Coordinator {
    
    func childAppend(_ child: CoordinatorProtocol) {
        for element in childCoordinators {
            if element === child { return }
        }
        childCoordinators.append(child)
    }
    
    func childRemove(_ child: CoordinatorProtocol?) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
}
