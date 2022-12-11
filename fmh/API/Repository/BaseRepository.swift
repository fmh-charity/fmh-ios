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
    
    func test() {
        DispatchQueue.main.async {
            
        }
    }
    
}
