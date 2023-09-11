
import Foundation
import Networking

// MARK: - NetworkService + Endpoint

extension NetworkService {
    
    struct Endpoint: Networking.Endpoint {
        
        var method: HTTPMethod
        var path: String
        var headers: Headers?
        var query: Query?
        var body: Data?
        
        init(
            method: HTTPMethod = .get,
            path: String,
            headers: Headers? = nil,
            query: Query? = nil,
            body: Data? = nil
        ) {
            self.method = method
            self.path = path
            self.headers = headers
            self.query = query
            self.body = body
        }
    }
}
