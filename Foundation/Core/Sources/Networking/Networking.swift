import Foundation

public protocol Networking {
    func perform(for endpoint: Endpoint) async throws -> (Data, URLResponse)
}
