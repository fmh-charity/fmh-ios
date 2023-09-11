
import Foundation

public protocol NetworkProtocol {
    func perform(for endpoint: Endpoint) async throws -> (Data, URLResponse)
}
