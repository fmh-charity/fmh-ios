
import Foundation

public final class NetworkingProvider {
    
    private let host: String
    private let urlSession: URLSession
    
    public init(host: String, urlSession: URLSession) {
        self.host = host
        self.urlSession = urlSession
    }
}

// MARK: - NetworkProtocol

extension NetworkingProvider: NetworkProtocol {
    
    public func perform(for endpoint: Endpoint) async throws -> (Data, URLResponse) {
        let urlRequest = try endpoint.makeURLRequest(host: host)
        let response = try await urlSession.data(for: urlRequest)
        // TODO: Добавить логирование!
        do {
            let (data, response) = try await responseHandler(response)
            print("Request: \(urlRequest.url?.absoluteString ?? "")")
            return (data, response)
        } catch {
            print("Error request: \(error)")
            throw error
        }
       
    }
}

// MARK: - FMHCore.Endpoint generate URLRequest

private extension Endpoint {
    
    func makeURLRequest(host: String) throws -> URLRequest {
        
        guard var urlComponents = URLComponents(string: host) else {
            throw NetworkingProviderError.invalidHost(String(describing: host))
        }
        
        urlComponents.path = path
        urlComponents.queryItems = self.query?.map {
            URLQueryItem(name: $0.key, value: $0.value?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
        }
        
        guard let url = urlComponents.url else {
            throw NetworkingProviderError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let body = body {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = body
        }
        
        self.headers?.forEach { request.addValue($0, forHTTPHeaderField: $1) }
        
        // TODO: Добавить зависимость для работы с токеном!
        if let token = UserDefaults.standard.object(forKey: "accessToken") as? String {
            request.setValue("\(token)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
}

// MARK: - NetworkingProviderError

private enum NetworkingProviderError: Error, LocalizedError {
    
    case invalidHost(_ host: String)
    case invalidUrl
    case responseError(_ code: Int, _ description: String)
    
    var errorDescription: String? {
        switch self {
        case let .invalidHost(host):
            return "URLComponents not initialize: host = \(host)"
        case .invalidUrl:
            return "URLComponents.url not initialize."
        case let .responseError(code, description):
            return "ResponseError: [\(code)], \(description)"
        }
    }
}

// MARK: - Response handler

private extension NetworkingProvider {
    
    func responseHandler(_ response: (Data, URLResponse)) async throws -> (Data, URLResponse){
        
        guard let urlResponse = response.1 as? HTTPURLResponse else {
            return response
        }
        
        if (200...299) ~= urlResponse.statusCode {
            return response
        }
        
        // If bad statusCode ...
        
        var description = "Answer is not equal code to 200...299. Code: \(urlResponse.statusCode)"
        if let dictionaryError = try? response.0.jsonObject() as? [String: Any] {
            
            // TODO: Проверить возможно violations словарь !
            
            description = dictionaryError["message"] as? String ?? ""
        }
        
        throw NetworkingProviderError.responseError(urlResponse.statusCode, description)
    }
}

// MARK: - Extension Data

private extension Data {
    
    func jsonObject() throws -> Any? {
        return try JSONSerialization.jsonObject(with: self, options: [])
    }
}
