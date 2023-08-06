//
//  AnalyticsTrackingProvider.swift
//  fmh
//
//  Created: 30.07.2023
//

import Foundation
import Core

final class AnalyticsTrackingProvider {
    
    // Dependencies
    // Need AppLogger protocol
    
    init() {
        
    }
}

// MARK: - AnalyticsTracking

extension AnalyticsTrackingProvider: AnalyticsTracking {
    
    func track(event: String, properties: PropertiesType) {
//        AppLogger.debug(event, properties) // <- Add Dependencies
        print(event, properties)
    }
    
    func track(_ event: Core.AnalyticsEvent) {
        track(event: event.name, properties: event.properties)
    }
}
