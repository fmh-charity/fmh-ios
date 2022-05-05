//
//  NetworkService.swift
//  fmh
//
//  Created: 30.04.2022
//

import Foundation

typealias URLParameters = Dictionary<String, String>
typealias HTTPHeaders = Dictionary<String, String>
typealias APIResponse<T: Decodable> = (Result<T, APIError>) -> Void


class NetworkService {
   
    var baseURLString: String?
    var globalPath: String?
    
    var timeoutInterval: TimeInterval = 30.0
    
    init() {
        let urlString = PListParser.getValueDictionary(forResource: "NetworkService", forKey: "testBaseURLString") as? String
        let path = PListParser.getValueDictionary(forResource: "NetworkService", forKey: "globalPath") as? String
        
        self.baseURLString = urlString
        self.globalPath = path
    }

    // MARK: - Basic method
    func getResurce<T>(with resource: APIResource<T>, completion: @escaping APIResponse<T>) where T: Decodable {

        guard let url = makeURL(path: resource.path, parametrs: resource.parametrs) else { return completion(.failure(.invalidURL)) }
        
        // TODO: нужен не для каждого запроса, подумать ?????
        /// НЕОБХОДИМО ДЛЯ КАЖДОГО ЗАПРОСА ПЕРЕКИДЫВАТЬ ТОКЕН, ПРОРАБАТЫВАЮ ВАРИАНТЫ !!!
        ///
        var headers: HTTPHeaders = resource.headers ?? [:]
        // headers["Authorization"] = accessToken

        // TODO: Реализовать прокидку ошибок как то
        let encodeBody = try? resource.body?.encode()
        
        let request = makeRequest(url: url, method: resource.method, headers: headers, body: encodeBody)

        rawRequest(with: request, completion: completion)
    }

}


// MARK: - Default property (Private)
extension NetworkService {
    
    private var session: URLSession {
        let config = URLSessionConfiguration.default
        config.urlCache = .none
        
        return URLSession(configuration: config, delegate: .none, delegateQueue: nil)
    }
    
    private var url: URL? {
        URL(string: self.baseURLString ?? "")
    }
  
    private var globalHeaders: HTTPHeaders? {
        [ "application/json; charset=utf-8" : "Content-Type" ] // добавить ios ?
    }
    
}


// MARK: - Factory methods (Private)
extension NetworkService {
    
    /// Создание URL
    ///
    /// !!! Рассмотреть возможность переноса в extension URL
    ///
    private func makeURL(path: String, parametrs: URLParameters? = nil) -> URL? {
        guard let url = url else { return nil }
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }
        components.path = (globalPath ?? "/") + path
        parametrs?.forEach{ components.queryItems?.append(URLQueryItem(name: $0, value: $1)) }
        return components.url
    }
    
    /// Создание URLRequest
    ///
    /// !!! Рассмотреть возможность переноса в extension URLRequest
    ///
    private func makeRequest(url: URL, method: HTTPMethod, headers: HTTPHeaders? = nil, body: Data? = nil) -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: timeoutInterval)
        request.httpMethod = method.rawValue
        request.httpBody = body
        globalHeaders?.forEach{ request.addValue($0, forHTTPHeaderField: $1) }
        headers?.forEach{ request.addValue($0, forHTTPHeaderField: $1) }
        return request
    }
    
}


// MARK: - Basic method (Private)
extension NetworkService {
    
    /// Основной метод отправки запроса и получения(обработки) ответа
    private func rawRequest<T>(with request: URLRequest, completion: @escaping APIResponse<T>) where T: Decodable {
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    return completion(.failure(.URLRequestError(error)))
                }

                if let response = response as? HTTPURLResponse, !(200...200).contains(response.statusCode) {
                    let discriptionCode = HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
                    completion(.failure(.HTTPURLResponse(statusCode: response.statusCode, description: discriptionCode)))
                    return
                }

                let decoder = JSONDecoder()
                do {
                    let decodeData = try decoder.decode(T.self, from: data ?? .init())
                    completion(.success(decodeData))
                } catch {
                    completion(.failure(.JSONDecoderError(error)))
                }
            }
        }
        task.resume()
    }

}


// MARK: -
/// ОБРАБОТЧИК ПЕРЕХВАТА ЗАПРОСОВ ДЛЯ ПИХАНИЯ ХИДЕРА С АВТОРИЗАЦИЕЙ
extension NetworkService {
    
}
