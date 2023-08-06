import Foundation

public final class AnalyticsTrackingProvider {
    
    // Dependencies
    // Need AppLogger protocol
    
    public init() {
        
    }
}

// MARK: - AnalyticsTracking

extension AnalyticsTrackingProvider: AnalyticsTracking {
    
    public func track(event: String, properties: PropertiesType) {
//        AppLogger.debug(event, properties) // <- Add Dependencies
        print(event, properties)
    }
    
    public func track(_ event: Core.AnalyticsEvent) {
        track(event: event.name, properties: event.properties)
    }
}
