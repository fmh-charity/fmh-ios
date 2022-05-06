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
   
    private var accessToken: String?
    
    var baseURLString: String?
    var globalPath: String?
    
    var timeoutInterval: TimeInterval = 5.0
    
    init() {
        
        // TODO:   Получаем из кейчан
        let accessToken = KeyChain.standart.get(forKey: "accessToken")  //UserDefaults.standard.string(forKey: "accessToken")
        let urlString = PListParser.getValueDictionary(forResource: "NetworkService", forKey: "testBaseURLString") as? String
        let path = PListParser.getValueDictionary(forResource: "NetworkService", forKey: "globalPath") as? String
        
        self.baseURLString = urlString
        self.globalPath = path
        self.accessToken = accessToken
    }

    // MARK: - Basic method
    func getResurce<T>(with resource: APIResource<T>, completion: @escaping APIResponse<T>) where T: Decodable {

        guard let url = makeURL(path: resource.path, parametrs: resource.parametrs) else { return completion(.failure(.invalidURL)) }

        // TODO: Реализовать прокидку ошибок как то
        let encodeBody = try? resource.body?.encode()
        
        let request = makeRequest(url: url, method: resource.method, headers: resource.headers, body: encodeBody)
        
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
    private func rawRequest<T>(with request: URLRequest, retries: Int = 2, completion: @escaping APIResponse<T>) where T: Decodable {
       
        // TODO: нужен не для каждого запроса, подумать ?????
        var headers: HTTPHeaders = [:]
        if let accessToken = accessToken {
            headers["Authorization"] = accessToken
        }
        var request = request
        headers.forEach{ request.addValue($0, forHTTPHeaderField: $1) }
        
        let task = session.dataTask(with: request) { [unowned self] data, response, error in
        
                if let error = error {
                    return completion(.failure(.URLRequestError(error)))
                }
                
                let statusCode = (response as! HTTPURLResponse).statusCode
            
                if statusCode == 401 && retries > 0 {
                    if self.refreshToken() {
                        
                        print("Received status code \(statusCode) with \(retries) retries remaining. RETRYING VIA RECURSIVE CALL.")
                        
                        self.rawRequest(with: request, retries: retries - 1, completion: completion)
                    }
                }

                if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    let discriptionCode = HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
                    return completion(.failure(.HTTPURLResponse(statusCode: response.statusCode, description: discriptionCode)))
                    
                }

                let decoder = JSONDecoder()
                do {
                    let decodeData = try decoder.decode(T.self, from: data ?? .init())
                    return completion(.success(decodeData))
                } catch {
                    return completion(.failure(.JSONDecoderError(error)))
                }
            
        }
        task.resume()
    }

}

// MARK:- Refresh token
extension NetworkService {
    
    private func refreshToken () -> Bool {
        
        // TODO: Считывать с кейчан
        let refreshToken = KeyChain.standart.get(forKey: "refreshToken") ?? ""
        //UserDefaults.standard.string(forKey: "refreshToken") ?? ""
        let resource: APIResource<TokenData> = APIResource(path: "authentication/refresh",
                                                           method: .post,
                                                           body: RefreshToken(refreshToken: refreshToken))
        
        guard let url = makeURL(path: resource.path) else { return false }
        
        var isRefresh: Bool = false
        
        let encodeBody = try? resource.body?.encode()
        let request = makeRequest(url: url, method: resource.method, body: encodeBody)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error != nil else { return }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    let decodeData = try decoder.decode(TokenData.self, from: data ?? .init())
                    
                    // TODO: запись новых данных в кейчан
                    KeyChain.standart.set(value: decodeData.accessToken, forKey: "accessToken")
                    KeyChain.standart.set(value: decodeData.refreshToken, forKey: "refreshToken")
                    //UserDefaults.standard.set(decodeData.accessToken, forKey: "accessToken")
                    //UserDefaults.standard.set(decodeData.refreshToken, forKey: "refreshToken")
                    
                    self.accessToken = decodeData.accessToken
                    isRefresh = true
                    return
                } catch {
                    return
                }
            }
        }
        return isRefresh
    }
    
}

