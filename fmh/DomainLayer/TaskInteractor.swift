//
//  TaskInteractor.swift
//  fmh
//
//  Created: 09.06.2022
//

import Foundation
import Combine

protocol TaskInteractorProtocol {
    func getAllTasks(completion: @escaping ([Tasks]?, NetworkError?) -> Void )
    func getTask(id: Int, completion: @escaping (Tasks?, NetworkError?) -> Void)
}

class TaskInteractor {
    private var repository: TaskRepositoryProtocol?
    private var anyCancellable = Set<AnyCancellable>()

    init(repository: TaskRepositoryProtocol?) {
        self.repository = repository
    }
}

// MARK: - AuthInteractorProtocol

extension TaskInteractor: TaskInteractorProtocol {
    func getAllTasks(completion: @escaping ([Tasks]?, NetworkError?) -> Void) {
        self.repository?.getAllTasks()
            .sink { anyCompletion in

                switch anyCompletion {

                case .failure(let error):
                    return completion(nil, error)

                case .finished:
                    break
                }
            }

    receiveValue: { dtoTask in
        let task = dtoTask.map { Tasks(createDate: $0.createDate,
                                         creatorId: $0.creatorId,
                                         creatorName: $0.creatorName,
                                         description: $0.description,
                                         executorId: $0.executorId,
                                         executorName: $0.executorName,
                                         factExecuteDate: $0.factExecuteDate,
                                         id: $0.id,
                                         planExecuteDate: $0.planExecuteDate,
                                         status: $0.status,
                                         title: $0.title)
        }
        return completion(task, nil)
    }
    .store(in: &anyCancellable)
    }

    func getTask(id: Int, completion: @escaping (Tasks?, NetworkError?) -> Void) {

        self.repository?.getTask(id: id)
            .sink { anyCompletion in

                switch anyCompletion {

                case .failure(let error):
                    return completion(nil, error)

                case .finished:
                    break
                }
            }

    receiveValue: { dtoTask in
        let task = Tasks(createDate: dtoTask.createDate,
                           creatorId: dtoTask.creatorId,
                           creatorName: dtoTask.creatorName,
                           description: dtoTask.description,
                           executorId: dtoTask.executorId,
                           executorName: dtoTask.executorName,
                           factExecuteDate: dtoTask.factExecuteDate,
                           id: dtoTask.id,
                           planExecuteDate: dtoTask.planExecuteDate,
                           status: dtoTask.status,
                           title: dtoTask.title)
        return completion(task, nil)
    }
    .store(in: &anyCancellable)
    }
}
