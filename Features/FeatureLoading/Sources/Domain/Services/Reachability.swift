//
//  Reachability.swift
//  
//
//  Created: 17.08.2023
//

import Network

protocol ReachabilityProtocol {
    func checkNetwork() -> Bool
}

// MARK: - Reachability

class Reachability {

    private let monitor = NWPathMonitor()
    private let queue: DispatchQueue
    private var isConnected = false
    
    init(queue: DispatchQueue = DispatchQueue(label: "Reachability")) {
        self.queue = queue
        monitorStart()
    }

    // MARK: Public
    
    func monitorStart() {
        monitor.pathUpdateHandler = { [weak self] pathUpdateHandler in
            self?.isConnected = pathUpdateHandler.status == .satisfied
        }
        monitor.start(queue: queue)
    }
    
    func monitorStop() {
        monitor.cancel()
    }
}

// MARK: ReachabilityProtocol

extension Reachability: ReachabilityProtocol {
    
    func checkNetwork() -> Bool {
        isConnected
    }
}
