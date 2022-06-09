//
//  TaskRepository.swift
//  fmh
//
//  Created: 09.06.2022
//

import Foundation
import Combine




protocol TaskRepositoryProtocol {

    func getAllTasks() -> AnyPublisher<[DTOTask], APIError>

    func getTask(id: Int) -> AnyPublisher<DTOTask, APIError>
}




class TaskRepository: Network {

    override init() {
        super.init()
    }
}




// MARK: - AuthRepositoryProtocol

extension TaskRepository: TaskRepositoryProtocol {

    func getAllTasks() -> AnyPublisher<[DTOTask], APIError> {

        let resource = APIResourceTasks.getAllTasks

        return fetchDataPublisher(resource: resource.resource())

            .map { $0 }

            .receive(on: DispatchQueue.main)

            .eraseToAnyPublisher()
    }

    func getNews(id: Int) -> AnyPublisher<DTOTask, APIError> {

        let resource = APIResourceTasks.getNews(id: id)

        return fetchDataPublisher(resource: resource.resource())
            .map { $0 }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
