//
//  Coordinator.swift
//  fmh
//
//  Created: 23.11.2022
//

import Foundation

protocol Coordinatable : AnyObject {
    var childCoordinators: [Coordinatable] { get set }
    var router: Routable { get }
    var onCompletion: (() -> Void)? { get set }
    func start()
}

// MARK: - Coordinator

class Coordinator: Coordinatable {
    
    var childCoordinators = [Coordinatable]()
    var router: Routable
    
    var onCompletion: (() -> Void)?
    
    init(router: Routable) {
        self.router = router
    }
    
    func start() {
        fatalError("CoordinatorBase: Need override in heir coordinator.")
    }
    
    // MARK: logic
    
    func childAppend(_ child: Coordinatable) {
        for element in childCoordinators {
            if element === child { return }
        }
        childCoordinators.append(child)
    }
    
    func childRemove(_ child: Coordinatable?) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
}
