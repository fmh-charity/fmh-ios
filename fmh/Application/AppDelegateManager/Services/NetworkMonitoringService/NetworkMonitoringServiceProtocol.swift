//
//  NetworkMonitoringServiceProtocol.swift
//  fmh
//
//  Created: 16.08.2023
//

import Foundation
import Combine
import Network

protocol NetworkMonitoringServiceProtocol: AnyObject {
    var state: StateSubject { get }
    func startMonitoring()
    func stopMonitoring()
    
    typealias StateSubject = CurrentValueSubject<(isReachable: Bool, isReachableOnCellular: Bool, connectionType: NWInterface.InterfaceType?)?, Never>
}

// MARK: - NWInterface.InterfaceType

extension NWInterface.InterfaceType: CaseIterable {
    public static var allCases: [NWInterface.InterfaceType] = [
        .other, .wifi, .cellular, .loopback, .wiredEthernet
    ]
}
