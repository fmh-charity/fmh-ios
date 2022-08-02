//
//  TaskRepository.swift
//  fmh
//
//  Created: 09.06.2022
//

import Foundation
import Combine




protocol TaskRepositoryProtocol {

    func getAllTasks() -> AnyPublisher<[DTOTask], NetworkError>

    func getTask(id: Int) -> AnyPublisher<DTOTask, NetworkError>
}




class TaskRepository: Network {

    override init() {
        super.init()
    }
}




// MARK: - AuthRepositoryProtocol

extension TaskRepository: TaskRepositoryProtocol {

    func getAllTasks() -> AnyPublisher<[DTOTask], NetworkError> {

        let resource = APIResourceTasks.getAllTasks

        return fetchDataPublisher(resource: resource.resource())
            .map { $0 }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func getTask(id: Int) -> AnyPublisher<DTOTask, NetworkError> {

        let resource = APIResourceTasks.getTasks(id: id)

        return fetchDataPublisher(resource: resource.resource())
            .map { $0 }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
