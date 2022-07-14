//
//  WishesInteractor.swift
//  fmh
//
//  Created: 12.07.22
//

import Foundation
import Combine

protocol WishesInteractorProtocol {
    func getAllwishes(completion: @escaping ([Wishes]?, NetworkError?) -> Void )
    func getWishes(id: Int, completion: @escaping (Wishes?, NetworkError?) -> Void)
}


class WishesInteractor {
    
    private var repository: WishesRepositoryProtocol?
    private var anyCancellable = Set<AnyCancellable>()
    
    init(repository: WishesRepositoryProtocol?) {
        self.repository = repository
    }
 
}

// MARK: - AuthInteractorProtocol
extension WishesInteractor: WishesInteractorProtocol {
   
    func getAllwishes(completion: @escaping ([Wishes]?, NetworkError?) -> Void) {
        self.repository?.getAllWishes()
            .sink { anyCompletion in
                switch anyCompletion {
                case .failure(let error):
                    return completion(nil, error)
                case .finished:
                    break
                }
            }
            receiveValue: { dtoWishes in
                let wishes = dtoWishes.map {
                    Wishes(createDate: $0.createDate,
                           creatorId: $0.creatorId,
                           description: $0.description,
                           executorId: $0.executorId,
                           factExecuteDate: $0.factExecuteDate,
                           id: $0.id,
                           patientId: $0.patientId,
                           planExecuteDate: $0.planExecuteDate,
                           status: $0.status,
                           title: $0.title)
                }
                return completion(wishes, nil)
            }
            .store(in: &anyCancellable)
    }

    func getWishes(id: Int, completion: @escaping (Wishes?, NetworkError?) -> Void) {
        self.repository?.getWishes(id: id)
            .sink { anyCompletion in
                switch anyCompletion {
                case .failure(let error):
                    return completion(nil, error)
                case .finished:
                    break
                }
            }
    receiveValue: { dtoWishes in
        let wishes = Wishes(createDate: dtoWishes.createDate,
                            creatorId: dtoWishes.creatorId,
                            description: dtoWishes.description,
                            executorId: dtoWishes.executorId,
                            factExecuteDate: dtoWishes.factExecuteDate,
                            id: dtoWishes.id,
                            patientId: dtoWishes.patientId,
                            planExecuteDate: dtoWishes.planExecuteDate,
                            status: dtoWishes.status,
                            title: dtoWishes.title)
        return completion(wishes, nil)
    }
    .store(in: &anyCancellable)
    }
    
}

