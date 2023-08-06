public protocol AnalyticsTracking {
    func track(event: String, properties: PropertiesType)
    func track(_ event: AnalyticsEvent)
    
    typealias PropertiesType = [String: Any]
}

public protocol AnalyticsEvent {
    var name: String { get }
    var properties: AnalyticsTracking.PropertiesType { get }
}
