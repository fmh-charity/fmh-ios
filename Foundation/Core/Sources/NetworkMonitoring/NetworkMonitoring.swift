//
//  NetworkMonitoring.swift
//  
//
//  Created: 06.08.2023
//

import Foundation
import Combine

public protocol NetworkMonitoringState {
    var state: PassthroughSubject<(isReachable: Bool, isReachableOnCellular: Bool), Never> { get }
}

public protocol NetworkMonitoringControl {
    func startMonitoring()
    func stopMonitoring()
}
