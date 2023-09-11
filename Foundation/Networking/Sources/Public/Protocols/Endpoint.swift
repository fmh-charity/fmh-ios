
import Foundation

public protocol Endpoint {
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: Headers? { get }
    var query: Query? { get }
    var body: Data? { get }
    
    typealias Headers = [String: String]
    typealias Query = [String: String?]
}

// MARK: - Defaults property

public extension Endpoint {
    var headers: Headers? { nil }
    var query: Query? { nil }
    var body: Data? { nil }
}
