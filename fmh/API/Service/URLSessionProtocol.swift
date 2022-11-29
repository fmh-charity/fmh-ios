//
//  URLSessionProtocol.swift
//  fmh
//
//  Created: 27.11.2022
//

import Foundation

protocol URLSessionProtocol {
    var session: URLSession { get }
    
    /// [ Decodable ] Запрос с использованием токена.
    func fetchData<T: Decodable>(request: URLRequest, completion: @escaping (T?, URLResponse?, Error?) -> Void)
    /// [ Data ] Запрос с использованием токена.
    func fetchData(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
    /// [ Data ] Запрос без токена.
    func fetch(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}


extension URLSessionProtocol {
    
    func fetchData<T: Decodable>(request: URLRequest, completion: @escaping (T?, URLResponse?, Error?) -> Void) {
        fetchData(request: request) { data, response, error in
            guard error == nil else { return completion(nil, response, error) }
            if let data = data  {
                do {
                    let decodeData = try JSONDecoder().decode(T.self, from: data)
                    return completion(decodeData, response, nil)
                } catch {
                    completion(nil, response, error)
                }
            }
            return completion(nil, response, error)
        }
    }
    
    func fetchData(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var request = request
        let token = Helper.Core.KeyChain.get(forKey: "accessToken")
        if let token = token { request.setValue("\(token)", forHTTPHeaderField: "Authorization") }
        
        fetch(request: request, completion: completion)
    }
    
    func fetch(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil, let response = response as? HTTPURLResponse else {
                return completion(nil, response, error)
            }
            if (200..<300).contains(response.statusCode), let data = data {
                return completion(data, response, nil)
            }
            let _error = NSError(domain: "URLResponse", code: response.statusCode)
            return completion(nil, response, _error)
        }
        task.resume()
    }
    
    //TODO: ВОЗМОЖНО ТУТ ЗАПИЛИТЬ НА ВСЕ ЗАПРОСЫ ПРОВЕРКУ 401 И ПОВТОРНЫЙ ЗАПРОС ПОСЛЕ ОБНОВЛЕНИЯ ТОКЕНА ?!
    //TODO: ИЛИ ЖЕ ВЫШЕ ГДЕНИТЬ...
    
}


// MARK: - URLRequest make/configure

enum HTTPMethod: String {
    case GET = "GET", POST = "POST", PUT = "PUT", DELETE = "DELETE"
}

typealias HTTPQuery = [String : String]?
typealias HTTPBody = Data? // [String : Any]


extension URLRequest {
    
//    init() throws {
//        guard var url = URL(string: "") else { throw NSError(domain: "", code: -1) }
//        url.path
//        url.pathComponents = []
//        var request = URLRequest(url: url)
//        request.httpMethod = ""
//        request.httpBody = nil
//        self = request
//    }
    
}

// MARK: - Helpers

extension URLComponents {
    
}

extension Data {
    
    func jsonObject() -> Any? {
        return (try? JSONSerialization.jsonObject(with: self, options: []))
    }
    
    func decode<T: Decodable>(_ decoder: JSONDecoder = JSONDecoder()) throws -> T {
        return try decoder.decode(T.self, from: self)
    }
    
}

extension Dictionary where Key == String, Value == Any? {
    
    func data(_ options: JSONSerialization.WritingOptions = []) throws -> Data {
        return try JSONSerialization.data(withJSONObject: self, options: options)
    }

}

extension Dictionary where Key == String, Value == String? {

    func queryItems()  -> [URLQueryItem]? {
        guard !self.isEmpty else { return nil }
        return self.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    
}

extension Encodable {
    
    func data(_ encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        return try encoder.encode(self)
    }
    
}
