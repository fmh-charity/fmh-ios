import Foundation
import Network
import Combine

public final class NetworkMonitoringProvider {
    
    // Dependencies
    private let queue: DispatchQueue
    
    private let monitor = NWPathMonitor()
    private var currentPath = PassthroughSubject<(isReachable: Bool, isReachableOnCellular: Bool), Never>()
    
    public init(queue: DispatchQueue = DispatchQueue(label: "NetworkMonitoringProvider")) {
        self.queue = queue
    }
}

// MARK: - NetworkMonitoringState

extension NetworkMonitoringProvider: NetworkMonitoringState {
    
    public var state: PassthroughSubject<(isReachable: Bool, isReachableOnCellular: Bool), Never> {
        currentPath
    }
}

// MARK: - NetworkMonitoringControl

extension NetworkMonitoringProvider: NetworkMonitoringControl {
    
    public func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.currentPath.send((path.status == .satisfied, path.isExpensive))
        }
        monitor.start(queue: queue)
    }
    
    public func stopMonitoring() {
        monitor.cancel()
        currentPath.send(completion: .finished)
    }
}
