//
//  Service.swift
//  fmh
//
//  Created: 09.05.2022
//

import Foundation
import Combine

protocol Service: AnyObject {
    
    var session: URLSession { get }
    
    func fetchDataPublisher <T: Decodable> (request: URLRequest) -> AnyPublisher<T, APIError>
    func fetchPublisher (request: URLRequest) -> AnyPublisher<Data, APIError>
    func fetchData <T: Decodable> (request: URLRequest, completion: @escaping (Result<T?, APIError>) -> Void )
    func fetch (request: URLRequest, completion: @escaping (Result<Data?, APIError>) -> Void )
    
}

extension Service {
    
    func fetchDataPublisher <T: Decodable> (request: URLRequest) -> AnyPublisher<T, APIError> {
        return fetchPublisher (request: request)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in error as! APIError }
            .eraseToAnyPublisher()
    }
    
    func fetchPublisher (request: URLRequest) -> AnyPublisher<Data, APIError> {
        return session.dataTaskPublisher(for: request)
            .tryMap({ data, response -> JSONDecoder.Input in
                if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    let discriptionCode = HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
                    throw APIError.HTTPURLResponse(statusCode: response.statusCode, description: discriptionCode)
                }
                return data
            })
            .mapError { error in
                print("Service.fetchPublisher.error: \(error)")
                return error as! APIError
            }
            .eraseToAnyPublisher()
    }
    
    func fetchData <T: Decodable> (request: URLRequest, completion: @escaping (Result<T?, APIError>) -> Void ) {
        fetch(request: request) { result in
            switch result {
                case .success(let data):
                    if let data = data {
                        do {
                            let decodeData = try JSONDecoder().decode(T.self, from: data)
                            return completion(.success(decodeData))
                        } catch {
                            return completion(.failure(.JSONDecoderError(error)))
                        }
                    }
                case .failure(let error):
                    return completion(.failure(error))
            }
        }
    }
    
    func fetch (request: URLRequest, completion: @escaping (Result<Data?, APIError>) -> Void ) {
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                return completion(.failure(.URLRequestError(error)))
            }
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                let discriptionCode = HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
                return completion(.failure(.HTTPURLResponse(statusCode: response.statusCode, description: discriptionCode)))
            }
            if let data = data {
                return completion(.success(data))
            }
        }
        task.resume()
    }
    
}
