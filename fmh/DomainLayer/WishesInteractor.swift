//
//  WishesInteractor.swift
//  fmh
//
//  Created: 12.07.22
//

import Foundation
import Combine

protocol WishesInteractorProtocol {
    func getAllWishes(completion: @escaping ([Wishes]?, NetworkError?) -> Void )
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
   
    func getAllWishes(completion: @escaping ([Wishes]?, NetworkError?) -> Void) {
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
                           creatorID: $0.creatorID,
                           description: $0.description,
                           executorID: $0.executorID,
                           factExecuteDate: $0.factExecuteDate,
                           id: $0.id,
                           patientID: $0.patientID,
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
                            creatorID: dtoWishes.creatorID,
                            description: dtoWishes.description,
                            executorID: dtoWishes.executorID,
                            factExecuteDate: dtoWishes.factExecuteDate,
                            id: dtoWishes.id,
                            patientID: dtoWishes.patientID,
                            planExecuteDate: dtoWishes.planExecuteDate,
                            status: dtoWishes.status,
                            title: dtoWishes.title)
        return completion(wishes, nil)
    }
    .store(in: &anyCancellable)
    }
    
}

