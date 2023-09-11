
import Foundation
import Networking

protocol NetworkServiceProtocol {
    func fetch<T>(endpoint: Networking.Endpoint, completion: @escaping (Error?, T?) -> Void) where T: Decodable
}

final class NetworkService {
    
    // Dependencies
    private var network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
}

// MARK: - NetworkServiceProtocol

extension NetworkService: NetworkServiceProtocol {
    
    func fetch<T>(endpoint: Networking.Endpoint, completion: @escaping (Error?, T?) -> Void) where T: Decodable {
        Task {
            do {
                let (data, _) = try await network.perform(for: endpoint)
                let decodeData = try JSONDecoder().decode(T.self, from: data)
                completion(nil, decodeData)
            } catch {
                completion(error, nil)
            }
        }
    }
}
