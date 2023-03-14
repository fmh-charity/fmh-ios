//
//  BaseRepository.swift
//  fmh
//
//  Created: 10.12.2022
//

import Foundation

protocol BaseRepositoryProtocol {

}

final class BaseRepository {
    
    private let apiClient: APIServiceProtocol //< - ??
    
    init(apiClient: APIServiceProtocol) { // <- ?
        self.apiClient = apiClient
    }
}

//MARK: - BaseRepositoryProtocol

extension BaseRepository: BaseRepositoryProtocol {
    
    func test(completion: @escaping (String?, Error?) -> ()) {
        guard let request = try? URLRequest(path: "/api/...") else { return }
        apiClient.fetchData(request: request) { dec, re, er in
            completion(dec, er)
        }
        
    }
}
