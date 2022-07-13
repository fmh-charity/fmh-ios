//
//  WishesRepository.swift
//  fmh
//
//  Created: 12.07.22
//

import Foundation
import Combine

protocol WishesRepositoryProtocol {

    func getAllWishes() -> AnyPublisher<[DTOWishes], NetworkError>
    func getWishes(id: Int) -> AnyPublisher<DTOWishes, NetworkError>
}

class WishesRepository: Network {
    
    override init() {
        super.init()
    }
    
}

// MARK: - AuthRepositoryProtocol
extension WishesRepository: WishesRepositoryProtocol {
    
    func getAllWishes() -> AnyPublisher<[DTOWishes], NetworkError> {
        let resource = APIResourceWishes.getAllWishes
        return fetchDataPublisher(resource: resource.resource())
            .map { $0 }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getWishes(id: Int) -> AnyPublisher<DTOWishes, NetworkError> {
        let resource = APIResourceWishes.getWishes(id: id)
        return fetchDataPublisher(resource: resource.resource())
            .map { $0 }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
