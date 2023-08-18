//
//  NetworkMonitoringService.swift
//  fmh
//
//  Created: 16.08.2023
//

import UIKit
import Network
import Combine

final class NetworkMonitoringService: NetworkMonitoringServiceProtocol {
    
    // MARK: Dependencies
    private let queue: DispatchQueue
    private let monitor = NWPathMonitor()
    
    // MARK: Public
    private(set) var state = NetworkMonitoringServiceProtocol.StateSubject(nil)
    
    init(queue: DispatchQueue = DispatchQueue(label: "NetworkMonitoringService")) {
        self.queue = queue
    }
    
    // MARK: - Public Monitoring
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            let connectionType = NWInterface.InterfaceType.allCases.filter { path.usesInterfaceType($0) }.first
            let value = (path.status == .satisfied, path.isExpensive, connectionType)
            self?.state.send(value)
            NotificationCenter.default.post(name: .networkMonitoringStatus, object: value)
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
        state.send(completion: .finished)
    }
}

// MARK: - Notification.Name

extension Notification.Name {
    static let networkMonitoringStatus = Notification.Name(rawValue: "networkMonitoringStatusChanged")
}

